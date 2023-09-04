#!/usr/bin/env bash

set -eo pipefail

VERSION=1.0.0
PLUGIN_VERSIONS_FILENAME="${ASDF_PLUGIN_MANAGER_PLUGIN_VERSIONS_FILENAME:-.plugin-versions}"
ADD_CLEAN="${ASDF_PLUGIN_MANAGER_ADD_CLEAN:-FALSE}"

print_version() {
    echo "${VERSION}"
}

print_plugin_versions_filename() {
    echo "${PLUGIN_VERSIONS_FILENAME}"
}

print_help() {
    cat <<EOF
Manage asdf plugins securely and declaratively via .plugin-versions file.
Using asdf-plugin-manager, you can set plugins Git URL and ref for security and integrity.

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
}

print_git_compare_url() {
    local provider_url="$1"
    local plugin_ref_current="$2"
    local plugin_ref_head="$3"

    if $(echo "${provider_url}" | grep -q 'github'); then
        echo "${plugin_url%.*}/compare/${plugin_ref_current}...${plugin_ref_head}"
    elif $(echo "${provider_url}" | grep -q 'gitlab'); then
        echo "${plugin_url%.*}/-/compare/${plugin_ref_current}...${plugin_ref_head}"
    fi
}

export_plugins() {
    asdf plugin-list --refs --urls | tr -s ' ' | cut -d ' ' -f 1,2,4 | column -t
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

add_plugins() {
    local managed_plugins="$1"
    echo "${managed_plugins}" | while read managed_plugin; do
        read -r plugin_name plugin_url plugin_ref < <(echo ${managed_plugin})
        echo "[INFO] Adding: ${plugin_name} ${plugin_url} ${plugin_ref}"
        if [[ "${ADD_CLEAN,,}" == 'true' ]]; then
            remove_plugins "$(list_plugins ${plugin_name})"
        fi
        asdf plugin add "${plugin_name}" "${plugin_url}"
        # TODO: Remove the plugin update once asdf supports adding plugin with git-ref.
        # https://github.com/asdf-vm/asdf/pull/1204
        asdf plugin update "${plugin_name}" "${plugin_ref}"
        echo "[INFO] Done."
    done
}

update_plugins() {
    local managed_plugins="$1"
    echo "${managed_plugins}" | while read managed_plugin; do
        read -r plugin_name plugin_url plugin_ref_current < <(echo ${managed_plugin})

        echo "[INFO] Updating: ${plugin_name} ${plugin_url} ${plugin_ref_current} to HEAD"
        asdf plugin update "${plugin_name}"
        plugin_ref_head="$(export_plugins | egrep "^\b${plugin_name}\b\s+" | sed -e 's/^.*\s//')"

        echo "[INFO] Updating git-ref in plugin version file: ${PLUGIN_VERSIONS_FILENAME}"
        sed -i "/^\b${plugin_name}\b/ s/${plugin_ref_current}/${plugin_ref_head}/" "${PLUGIN_VERSIONS_FILENAME}"

        echo '!!!'
        echo '[CAUTION] Please review the changes since last update:'
        echo "$(print_git_compare_url ${plugin_url} ${plugin_ref_current} ${plugin_ref_head})"
        echo '!!!'

        echo "[INFO] Done."
    done
}

if [[ -z $1 ]]; then
    print_help
    exit 1
fi

while test -n "$1"; do
    case "$1" in
    help | -h)
        print_help
        exit 1
        ;;
    version | -v)
        print_version
        exit 0
        ;;
    export)
        export_plugins
        ;;
    list)
        list_plugins
        ;;
    add)
        add_plugins "$(list_plugins $2)"
        ;;
    add-all)
        add_plugins "$(list_plugins)"
        ;;
    update)
        update_plugins "$(list_plugins $2)"
        ;;
    update-all)
        update_plugins "$(list_plugins)"
        ;;
    remove)
        remove_plugins "$(list_plugins $2)"
        ;;
    remove-all)
        remove_plugins "$(list_plugins)"
        ;;
    *)
        echo "Unknown argument: $1"
        print_help
        exit 1
        ;;
    esac
    shift
done
