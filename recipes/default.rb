#
# Cookbook:: krona
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'git'

git 'checkout krona src code' do
  destination node['krona']['src_dir']
  repository node['krona']['src_repo']
  revision node['krona']['version']
  action 'export'
end

execute 'install krona' do
  command 'perl install.pl'
  cwd "#{node['krona']['src_dir']}/KronaTools"
end

# Create the taxonomy dir needed by updateTaxonomy
directory "#{node['krona']['src_dir']}/KronaTools/taxonomy" do
  action :create
end

execute 'run updateTaxonomy.sh to update taxonomy' do
  command './updateTaxonomy.sh'
  cwd "#{node['krona']['src_dir']}/KronaTools"
end
