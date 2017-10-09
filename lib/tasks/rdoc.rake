require 'rdoc/task'

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'documentation/full_app_documentation'
  rdoc.rdoc_files.include('README.md', 'app/', 'lib/')
end