#!/usr/bin/env bash
# Stub install.sh
# TODO: make this smarter, though works
# sudo dpkg etc.

echo ${version}
sleep 10

sudo rpm -ivh /chef/installer/chef-12.3.0-1.el6.x86_64.rpm
