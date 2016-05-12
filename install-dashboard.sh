#!/usr/bin/env bash

check_user() {
    if [[  "${USER}" != "dashing" ]]; then
        error "You must run the script as the 'dashing' user."
    fi
}

check_user

rbenv install 2.3.1
rbenv local 2.3.1

gem install bundler dashing

dashing new dashboard
cd dashboard
bundle

