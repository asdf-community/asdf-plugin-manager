#!/usr/bin/env bash

shellcheck --shell=bash --external-sources \
    bin/* --source-path=template/lib/ \
    lib/* \
    scripts/*

shfmt -i 4 --language-dialect bash --diff \
    ./**/*
