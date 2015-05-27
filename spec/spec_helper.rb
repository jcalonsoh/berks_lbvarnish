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

at_exit { ChefSpec::Coverage.report! }
