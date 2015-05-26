#
# Cookbook Name:: agentJ_nginx
# Recipe:: default
# ChefSpec:: Unit Test
# Copyright (C) 2015 Juan Carlos Alonso Holmstron
#
# All rights reserved - Do Not Redistribute
#

require File.expand_path('spec/spec_helper')

describe 'agentJ_lbvarnish::default' do
  let(:tempy) { Chef::Config[:file_cache_path] }
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |_node, server|
      server.create_role('agentJwebserver')
      node_web1 = stub_node('node_web1', platform: 'centos', version: '6.6')
      node_web1.set['network']['interfaces']['eth1']['addresses']['172.17.101.103'] = {
        'netmask' => '255.255.255.0',
        'broadcast' => '172.17.101.101',
        'family' => 'inet'
      }
      node_web1.set['agentJwebserver'] = true
      node_web1.automatic['hostname'] = 'web1-chef-centos-66.vagrantup.com'
      server.create_node(node_web1,  run_list: ['role[agentJwebserver]'])
      node_web2 = stub_node('node_web2', platform: 'centos', version: '6.6')
      node_web2.set['network']['interfaces']['eth1']['addresses']['172.17.101.104'] = {
        'netmask' => '255.255.255.0',
        'broadcast' => '172.17.101.101',
        'family' => 'inet'
      }
      node_web2.set['agentJwebserver'] = true
      node_web2.automatic['hostname'] = 'web2-chef-centos-66.vagrantup.com'
      server.create_node(node_web2, run_list: ['role[agentJwebserver]'])
    end.converge(described_recipe)
  end

  before('remote_file') do
    expect(chef_run).to create_remote_file("#{tempy}/varnish-3.0.el6.rpm")
  end

  context 'Downloading and Installing REPO Varnish' do
    it 'Test download remote_file rpm' do
      expect(chef_run).to create_remote_file("#{tempy}/varnish-3.0.el6.rpm")
    end

    it 'Test RPM instalation of varnish REPO after remote_file' do
      expect(chef_run).to install_rpm_package("#{tempy}/varnish-3.0.el6.rpm")
    end

    it 'Test Installing Varnish Service after remote_file' do
      expect(chef_run).to install_package('varnish')
    end
  end

  context 'Enabling and Starting Varnish after ' do
    it 'Test starts a service varnish after remote_file' do
      expect(chef_run).to start_service('varnish')
    end

    it 'Test starts a service varnish after remote_file' do
      expect(chef_run).to start_service('varnish')
    end
  end

  context 'Template File find' do
    it 'template file after remote_file' do
      expect(chef_run).to create_template('default.vcl')
    end
  end

  context 'Find servers and role for template' do
    it 'searches the Chef Server for roles' do
      expect(chef_run).to write_log('nodes with an attribute').with_message(<<-EOH.gsub(/^ {8}/, '').strip)
        node_web1, hostname: web1-chef-centos-66.vagrantup.com, ip: 172.17.101.103
        node_web2, hostname: web2-chef-centos-66.vagrantup.com, ip: 172.17.101.104
      EOH
    end
  end
end
