#!/bin/bash

setup_python() {
    #python
    pip install virtualenv
    virtualenv .appium-io
    source .appium-io/bin/activate
    pip install mkdocs==0.16.3
}

setup_ruby() {
    # ruby
    if [ -f $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm && type rvm|grep -q "is a function"
    then
        echo "RVM is already installed!"
    else
        \curl -sSL https://get.rvm.io | bash -s -- --ruby=2.5.1 --ignore-dotfiles stable --autolibs=ignore-fail --gems=bundler
    fi
    if rvm list rubies|grep -q 2.5.1
    then
        echo "ruby 2.5.1 is already installed"
        rvm use 2.5.1
        rvm gemset use ${project_name} --create
    else
        source $HOME/.rvm/scripts/rvm
        rvm install 2.5.1
        rvm gemset use ${project_name} --create
        gem install bundler
        bundle install
    fi
}

setup_node() {
    #node
    npm install
}

setup() {
    setup_ruby
    setup_python
    setup_node
}

while :
do
    case "$1" in
        setup_python)
            setup_python
            exit 0
            ;;
        setup_ruby)
            setup_ruby
            exit 0
            ;;
        setup_node)
            setup_node
            exit 0
            ;;
        *)
            setup
            exit 0
            ;;
    esac
done
