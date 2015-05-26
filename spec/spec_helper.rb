#
# Cookbook Name:: agentJ_loadbalancer
# Recipe:: default
# ChefSpec:: Spec Helper
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#
# spec_helper.rb

require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

RSpec.configure do |config|
  config.before(:each) do
    Chef::Config[:file_cache_path] = '/tmp/chef_cache'
  end
end

at_exit { ChefSpec::Coverage.report! }
