#!/usr/bin/env bash

set -eo pipefail

#
# Vars.
#

# x-release-please-start-version
VERSION=1.5.0
# x-release-please-end
PLUGIN_VERSIONS_FILENAME="${ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME:-.plugin-versions}"
ADD_CLEAN="${ASDF_PLUGIN_MANAGER_ADD_CLEAN:-FALSE}"
PLUGINS_REPOS_DIR="$(asdf info | grep ASDF_DATA_DIR | cut -d"=" -f2)/plugins"

#
# Functions.
#

print_version() {
    echo "${VERSION}"
}

print_plugin_versions_filename() {
    echo "${PLUGIN_VERSIONS_FILENAME}"
}

print_help() {
    cat <<EOF
asdf-plugin-manager

Manage asdf plugins securely and declaratively via ".plugin-versions" file.
Using asdf-plugin-manager, you can set plugins Git URL and Ref for security and integrity.

VARS:
  ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME: Set default name for the file with the list of managed plugins.
                                                Default: "$(print_plugin_versions_filename)".
  ASDF_PLUGIN_MANAGER_ADD_CLEAN:                Remove the plugin before adding it if it's already installed.
                                                Default: "FALSE".

USAGE:
  asdf-plugin-manager help                    : Print this help message
  asdf-plugin-manager version                 : Print asdf-plugin-manager current version
  asdf-plugin-manager export                  : List currently installed plugins to be used in .plugin-versions
  asdf-plugin-manager list                    : List plugins in .plugin-versions file
  asdf-plugin-manager add <plugin-name>       : Add named plugin according to .plugin-versions file
  asdf-plugin-manager add-all                 : Add all plugins according to .plugin-versions file
  asdf-plugin-manager update <plugin-name>    : Update named plugin to latest in the system and in the .plugin-versions file
  asdf-plugin-manager update-all              : Update all plugins to latest in the system and in the .plugin-versions file
  asdf-plugin-manager remove <plugin-name>    : Remove named plugin according to .plugin-versions file
  asdf-plugin-manager remove-all              : Remove all plugins according to .plugin-versions file
EOF

    exit 1
}

print_git_compare_url() {
    local provider_url="$1"
    local plugin_ref_current="$2"
    local plugin_ref_head="$3"

    case "${provider_url}" in
    *github*)
        echo "${provider_url%.*}/compare/${plugin_ref_current}...${plugin_ref_head}"
        ;;
    *gitlab*)
        echo "${provider_url%.*}/-/compare/${plugin_ref_current}...${plugin_ref_head}"
        ;;
    *)
        echo "Unknown provider: ${provider_url}"
        ;;
    esac
}

export_plugins() {
    asdf plugin list --refs --urls | tr -s ' ' | cut -d ' ' -f 1,2,4 | column -t
}

# Mimic 'asdf plugin update' to avoid "fatal: couldn't find remote ref ...".
checkout_plugin_ref() {
    plugin_name="${1}"
    plugin_ref="${2}"
    git_dir="${PLUGINS_REPOS_DIR}/${plugin_name}"

    git --git-dir "${git_dir}/.git" \
        --work-tree "${git_dir}" \
        checkout "${plugin_ref}"
}

list_plugins() {
    plugin_name=$1
    if [[ -n ${plugin_name} ]]; then
        grep "^${plugin_name} " "$(print_plugin_versions_filename)"
    else
        grep -v "^#" "$(print_plugin_versions_filename)"
    fi
}

remove_plugins() {
    local managed_plugins="$1"
    echo "${managed_plugins}" | while read managed_plugin; do
        read -r plugin_name _plugin_url _plugin_ref < <(echo ${managed_plugin})
        echo "[INFO] Removing: ${plugin_name}"
        asdf plugin remove "${plugin_name}" || true
    done
}

validate_plugin_git_url() {
    local plugin_name="$1"
    local plugin_url="$2"
    plugin_url_installed="$(asdf plugin list --refs --urls | sed -n "/${plugin_name}/p" | tr -s ' ' | cut -d " " -f 2)"
    if [[ -n "${plugin_url_installed}" && "${plugin_url_installed}" != "${plugin_url}" ]]; then
        printf "%s %s %s\n" \
            "[CRIT] The managed plugin ${plugin_name} repo is ${plugin_url}" \
            "which differs from the currency installed one ${plugin_url_installed}!" \
            "This probably implies a security threat!"
    fi
}

remove_plugin_or_notify() {
    local plugin_name="$1"
    local plugin_url="$2"
    if [[ "$(echo ${ADD_CLEAN} | tr '[:upper:]' '[:lower:]')" == 'true' ]]; then
        remove_plugins "$(list_plugins ${plugin_name})"
    else
        validate_plugin_git_url "${plugin_name}" "${plugin_url}"
    fi
}

add_plugins() {
    local managed_plugins="$1"
    echo "${managed_plugins}" | while read managed_plugin; do
        read -r plugin_name plugin_url plugin_ref < <(echo ${managed_plugin})
        echo "[INFO] Adding: ${plugin_name} ${plugin_url} ${plugin_ref}"
        remove_plugin_or_notify "${plugin_name}" "${plugin_url}"
        asdf plugin add "${plugin_name}" "${plugin_url}"
        # TODO: Remove the plugin update once asdf supports adding plugin with git-ref.
        # https://github.com/asdf-vm/asdf/pull/1204
        checkout_plugin_ref "${plugin_name}" "${plugin_ref}"
        echo "[INFO] Done."
    done
}

update_plugins() {
    local managed_plugins="$1"
    echo "${managed_plugins}" | while read managed_plugin; do
        read -r plugin_name plugin_url plugin_ref_managed < <(echo ${managed_plugin})

        echo "[INFO] Updating: ${plugin_name} ${plugin_url} ${plugin_ref_managed} to HEAD"
        plugin_ref_before_update="$(export_plugins | grep -E "^\b${plugin_name}\b\s+" | sed -e 's/^.*\s//')"
        asdf plugin update "${plugin_name}"
        plugin_ref_after_update="$(export_plugins | grep -E "^\b${plugin_name}\b\s+" | sed -e 's/^.*\s//')"

        if [[ "${plugin_ref_before_update}" == "${plugin_ref_after_update}" ]]; then
            echo "[INFO] The plugin \"${plugin_name}\" with git-ref \"${plugin_ref_managed}\" is already up-to-date."
            continue
        fi

        echo "[INFO] Updating git-ref in plugin version file: $(print_plugin_versions_filename)"
        cat "$(print_plugin_versions_filename)" |
            sed "/^\b${plugin_name}\b/ s/${plugin_ref_managed}/${plugin_ref_after_update}/" |
            tee "$(print_plugin_versions_filename)"

        echo '!!!'
        echo "[CRIT] Please review the changes since last update:"
        echo "$(print_git_compare_url ${plugin_url} ${plugin_ref_managed} ${plugin_ref_after_update})"
        echo '!!!'

        echo "[INFO] Done."
    done
}

#
# Main.
#

# Check basic args.
case "$1" in
help | -h | "")
    print_help
    ;;
version | -n)
    print_version
    exit 0
    ;;
esac

# Check if the plugin versions file exists.
if ! test -f "$(print_plugin_versions_filename)"; then
    echo -e "[ERROR] The '$(print_plugin_versions_filename)' file is not found. Check help for more details:\n"
    print_help
fi

while test -n "$1"; do
    case "$1" in
    export)
        export_plugins
        ;;
    list)
        list_plugins
        ;;
    add)
        test -n "$2" || print_help
        add_plugins "$(list_plugins $2)"
        shift
        ;;
    add-all)
        add_plugins "$(list_plugins)"
        ;;
    update)
        test -n "$2" || print_help
        update_plugins "$(list_plugins $2)"
        shift
        ;;
    update-all)
        update_plugins "$(list_plugins)"
        ;;
    remove)
        test -n "$2" || print_help
        remove_plugins "$(list_plugins $2)"
        shift
        ;;
    remove-all)
        remove_plugins "$(list_plugins)"
        ;;
    *)
        echo "Unknown argument: $1"
        print_help
        ;;
    esac
    shift
done
