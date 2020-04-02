# # encoding: utf-8

# Inspec test for recipe krona::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

#require_relative './spec_helper.rb'

describe command('. /etc/profile; ktImportTaxonomy') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/KronaTools 2.7 - ktImportTaxonomy/) }
end

describe command('. /etc/profile; ktImportText /usr/local/krona_src/KronaTools/test/krona_test.txt -o krono.html') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Writing krono.html.../) }
end
