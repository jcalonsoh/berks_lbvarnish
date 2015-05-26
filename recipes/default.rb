#
# Cookbook Name:: agentJ_lbvarnish
# Recipe:: default
#
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

if Chef::Config[:solo] && node['fail_on_seach_with_chefsolo']
  return fail node['error']['search_not_supported']
end

include_recipe 'agentJ_lbvarnish::install'

servers = []

search(:node, 'role:agentJwebserver').each do |server|
  serv = server['network']['interfaces']['eth1']['addresses']
  servers << serv.detect { |_, value| value['family'] == 'inet' }.first
end

template "default.vcl" do
  source "default.vcl.erb"
  path "/etc/varnish/default.vcl"
  variables(servers: servers)
  notifies :restart, 'service[varnish]', :immediately
end

service "varnish" do
  action [ :enable, :start ]
end

nodes = search(:node, 'agentJwebserver: *')
log 'nodes with an attribute' do
  message nodes.map { |node|
            "#{node.name}, hostname: #{node['hostname']}, ip: #{node['network']['interfaces']['eth1']['addresses'].detect { |_, value| value['family'] == 'inet' }.first}"
          }.join("\n")
end
