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
set :os, :family => 'redhat', :release => '6', :arch => 'x86_64'

describe package('varnish') do
  it { should be_installed }
end