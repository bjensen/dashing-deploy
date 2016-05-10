#!/usr/bin/env bash

USER=dashing
USER_HOME=/home/dashing

error() {
    local msg="${1}"
    echo "${msg}"
    exit 1
}

check_root() {
    if [ "$(id -u)" != "0" ]; then
        error "You must run the script as the 'root' user."
    fi
}

install_dependencies(){
  apt-get install -y git-core curl nodejs zlib1g-dev build-essential libssl-dev \
          libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
          libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

}

install_rbenv(){
  cd ${USER_HOME}
  git clone https://github.com/rbenv/rbenv.git .rbenv
  cd ${USER_HOME}/.rbenv && src/configure && make -C src
}

install_ruby_build(){
  git clone git://github.com/sstephenson/ruby-build.git ${USER_HOME}/.rbenv/plugins/ruby-build
}

update_bashrc(){
  cat >> ${USER_HOME}/.bashrc <<'EOF'
export PATH="~/.rbenv/bin:${PATH}"
export PATH="~/.rbenv/plugins/ruby-build/bin:${PATH}"
eval "$(rbenv init -)"
EOF
}

check_root

apt-get update

# adduser dashing
# sudo su dashing

install_rbenv
install_ruby_build
chown -R dashing: ${USER_HOME}/.rbenv

# TODO: as dashing user do this
# rbenv install 2.3.1
# gem install bundle
# dashing new dashboard
# mv dashboard /srv/www/
# update KEY in config.ru

# TODO; create upstart script

update_bashrc
