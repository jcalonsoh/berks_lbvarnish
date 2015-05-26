#
# Cookbook Name:: agentJ_lbvarnish
# Recipe:: default
#
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

src_file = "#{Chef::Config[:file_cache_path]}/varnish-3.0.el6.rpm"

remote_file src_file do
  source "https://repo.varnish-cache.org/redhat/varnish-3.0.el6.rpm"
end

rpm_package "varnish" do
  package_name src_file
  action :install
end

package "varnish"
