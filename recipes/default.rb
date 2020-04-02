#
# Cookbook:: krona
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

apt_update
build_essential

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

# add in a test file
# Create a test dir
directory "#{node['krona']['src_dir']}/KronaTools/test" do
  action :create
end

cookbook_file "#{node['krona']['src_dir']}/KronaTools/test/krona_test.txt" do
  source 'krona_test.txt'
end

magic_shell_environment 'KRONA_VERSION' do
  value node['krona']['version']
end
