#
# Cookbook Name:: agentJ_lbvarnish
# Recipe:: default
#
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/varnish-3.0.el6.rpm" do
  source "https://repo.varnish-cache.org/redhat/varnish-3.0.el6.rpm"
end

rpm_package "varnish" do
  package_name "#{Chef::Config[:file_cache_path]}/varnish-3.0.el6.rpm"
  action :install
end

package "varnish"

# package "httpd"
#
# service "httpd" do
#   action [ :enable, :start ]
# end
#
#
#
# service "varnish" do
#   action [ :enable, :start ]
# end
