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
#  let(:shellout) { double('shellout') }
  let(:tempy) { Chef::Config[:file_cache_path] }
  let(:ip_node_web1) { '172.17.101.103' }
  let(:ip_node_web2) { '172.17.101.104' }
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node, server|
      server.create_role('agentJwebserver', {run_list: 'recipe[agentJ_nginx]'})
      node_web1 = stub_node('web1-chef-centos-66.vagrantup.com', platform: 'centos', version: '6.6')
      node_web1.set['network']['interfaces']['eth1']['addresses']["#{ip_node_web1}"] = {
          'netmask' => '255.255.255.0',
          'broadcast' => '172.17.101.101',
          'family' => 'inet'
      }
      server.create_node(node_web1,  { run_list: ['role[agentJwebserver]']})
      node_web2 = stub_node('web2-chef-centos-66.vagrantup.com', platform: 'centos', version: '6.6')
      node_web2.set['network']['interfaces']['eth1']['addresses']["#{ip_node_web2}"] = {
          'netmask' => '255.255.255.0',
          'broadcast' => '172.17.101.101',
          'family' => 'inet'
      }
      server.create_node(node_web2, { run_list: ['role[agentJwebserver]']})
    end.converge(described_recipe)
  end

=begin
  before do
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
    allow(shellout).to receive(:run_command).and_return(shellout)
  end
=end

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

  it 'template file after remote_file' do
    expect(chef_run).to create_template('default.vcl')

    #expect(@servers).to match(ip_node_web1)

    #expect(chef_run).to render_file('default.vcl.erb')
    #                        .with_content("#{ip_node_web1}")

  end

end
