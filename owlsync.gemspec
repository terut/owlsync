# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "owlsync/version"

Gem::Specification.new do |s|
  s.name        = "owlsync"
  s.version     = Owlsync::VERSION
  s.authors     = ["terut"]
  s.email       = ["terut.dev+github@gmail.com"]
  s.homepage    = "https://github.com/terut/owlsync"
  s.summary     = %q{The Mirroring Daemon for Auto Scaling}
  s.description = %q{Owlsync is an easy configure, easy to rsync source written in Ruby.}

  s.rubyforge_project = "owlsync"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-doc"
  s.add_runtime_dependency "aws-sdk"
  s.add_runtime_dependency "daemons"
end
