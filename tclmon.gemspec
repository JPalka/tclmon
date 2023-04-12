Gem::Specification.new do |s|
  s.name      = 'tclmon'
  s.version   = '0.0.0'
  s.platform  = Gem::Platform::RUBY
  s.summary   = 'TCL Link Zone 4G router monitor'
  s.description = 'Monitoring tool for TCL Link Zone router. Allows querying device state without using its garbage, laggy UI'
  s.authors   = ['Jan Palka']
  s.email     = ['jan.j.palka@gmail.com']
  s.homepage  = 'http://rubygems.org/gems/tclmon'
  s.license   = 'MIT'
  s.files     = Dir.glob("{lib,bin}/**/*") # This includes all files under the lib directory recursively, so we don't have to add each one individually.
  s.require_path = 'lib'
  s.executables = ['tclmon']
end
