#!/usr/bin/env rake
# encoding: UTF-8

require 'net/http'
require 'rake/testtask'

task :default => [:"get-latest-files"]

desc "Updates the version of sir-trevor to the latest version in the Github repository"
task :"get-latest-files" do
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end
