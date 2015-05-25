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
  let(:shellout) { double('shellout') }
  let(Chef::Config[:file_cache_path]) {'/tmp/cache'}
  let(:tempy) { Chef::Config[:file_cache_path] }
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node, server|
      server.create_role('agentJwebserver', {run_list: 'recipe[agentJ_nginx]'})
      node_web1 = stub_node('web1-chef-centos-66.vagrantup.com', platform: 'centos', version: '6.6')
      node_web1.set['network']['interfaces']['eth1']['addresses']['172.17.101.103'] = {
          'netmask' => '255.255.255.0',
          'broadcast' => '172.17.101.101',
          'family' => 'inet'
      }
      server.create_node(node_web1,  { run_list: ['role[agentJwebserver]']})
      node_web2 = stub_node('web2-chef-centos-66.vagrantup.com', platform: 'centos', version: '6.6')
      node_web2.set['network']['interfaces']['eth1']['addresses']['172.17.101.104'] = {
          'netmask' => '255.255.255.0',
          'broadcast' => '172.17.101.101',
          'family' => 'inet'
      }
      server.create_node(node_web2, { run_list: ['role[agentJwebserver]']})
    end.converge(described_recipe)
  end

  before do
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    allow(shellout).to receive(:run_command).and_return(shellout)
  end

#  after do
#    File.exists?("#{tempy}/varnish-3.0.el6.rpm").and_return(false)
#  end

  context 'Downloading and Installing REPO Varnish' do
    it 'Test download remote_file rpm' do
      expect(chef_run).to create_remote_file("#{tempy}/varnish-3.0.el6.rpm")
    end

    it 'Test RPM instalation of varnish REPO' do
      expect(chef_run).to install_rpm_package("#{tempy}/varnish-3.0.el6.rpm")
    end

    it 'Test Installing Varnish Service' do
      expect(chef_run).to install_package('varnish')
    end
  end


  context 'Enabling and Starting Varnish' do
    it 'Test starts a service varnish' do
      expect(chef_run).to start_service('varnish')
    end

    it 'Test starts a service varnish' do
      expect(chef_run).to start_service('varnish')
    end
  end

end
