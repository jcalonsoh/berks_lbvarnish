#
# Cookbook Name:: agentJ_lbvarnish
# Recipe:: default
#
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

#include_recipe 'agentJ_lbvarnish::install'
#include_recipe 'varnish::default'

varnish_install 'default' do
  package_name 'varnish'
  vendor_repo true
  vendor_version '3.0'
end