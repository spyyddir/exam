# -*- encoding: utf-8 -*-
require File.expand_path('../lib/exam/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Zac Clark", "Georg Apitz"]
  gem.email         = ["zac@pivotallabs.com", "georg@pivotallabs.com"]
  gem.description   = %q{A test suite runner for ruby.}
  gem.summary       = %q{Uses a Suitefile to run large test suites.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "exam"
  gem.require_paths = ["lib"]
  gem.version       = Exam::VERSION
end
