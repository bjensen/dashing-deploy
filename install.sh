#!/usr/bin/env bash

HERE=$(dirname $(readlink -f $0))

DASHING_USER=dashing
DASHING_USER_HOME=/home/dashing

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
  apt-get install -y nginx git-core curl nodejs zlib1g-dev build-essential libssl-dev \
          libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
          libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

}

install_rbenv(){
  cd ${DASHING_USER_HOME}
  git clone https://github.com/rbenv/rbenv.git .rbenv
  cd ${DASHING_USER_HOME}/.rbenv && src/configure && make -C src
}

install_ruby_build(){
  git clone git://github.com/sstephenson/ruby-build.git ${DASHING_USER_HOME}/.rbenv/plugins/ruby-build
}

install_dashboard(){
  sudo --user=${DASHING_USER} --login ${HERE}/install-dashboard.sh
  mv ${DASHING_USER_HOME}/dashboard /srv/www/dashboard
}

prepare_user(){
  adduser ${DASHING_USER}

  cat >> ${DASHING_USER_HOME}/.profile <<'EOF'
export PATH="~/.rbenv/bin:${PATH}"
export PATH="~/.rbenv/plugins/ruby-build/bin:${PATH}"
eval "$(rbenv init -)"
EOF

  chown -R dashing: ${DASHING_USER_HOME}/.rbenv
}

configure_nginx(){
  rm /etc/nginx/sites-enabled/default
  rm /etc/nginx/sites-available/default
}

check_root

apt-get update

install_rbenv
install_ruby_build

prepare_user
install_dashboard

configure_nginx

# update KEY in config.ru

# TODO; create upstart script



