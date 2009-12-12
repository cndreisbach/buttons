require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['tests/**/*_tests.rb']
  t.libs << 'test'
end