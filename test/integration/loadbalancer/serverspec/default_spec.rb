#
# Cookbook Name:: agentJ_lbvarnish
# Recipe:: default
# ServerSpec:: loadbalancer
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

require 'serverspec'
set :backend, :exec
set :os, family: 'redhat', release: '6', arch: 'x86_64'

describe package('varnish-release') do
  it { should be_installed }
end

describe package('varnish') do
  it { should be_installed }
end

describe service('varnish') do
  it { should be_enabled }
end

describe service('varnish') do
  it { should be_running }
end

describe process('varnishd') do
  it { should be_running }
end

describe port(6081) do
  it { should be_listening }
end

describe file('/etc/sysconfig/varnish') do
  it { should be_file }
end

describe file('/etc/varnish/default.vcl') do
  it { should be_file }
end

describe file('/etc/varnish/default.vcl') do
  its(:content) { should match /172.17.101.104/ }
end

describe file('/etc/varnish/default.vcl') do
  its(:content) { should match /172.17.101.103/ }
end
