# -*- encoding: utf-8 -*-
# stub: sidekiq-cron 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sidekiq-cron".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ondrej Bartas".freeze]
  s.date = "2020-04-03"
  s.description = "Enables to set jobs to be run in specified time (using CRON notation)".freeze
  s.email = "ondrej@bartas.cz".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = [".document".freeze, ".travis.yml".freeze, "Changes.md".freeze, "Dockerfile".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "config.ru".freeze, "docker-compose.yml".freeze, "examples/web-cron-ui.png".freeze, "lib/sidekiq-cron.rb".freeze, "lib/sidekiq/cron.rb".freeze, "lib/sidekiq/cron/job.rb".freeze, "lib/sidekiq/cron/launcher.rb".freeze, "lib/sidekiq/cron/locales/de.yml".freeze, "lib/sidekiq/cron/locales/en.yml".freeze, "lib/sidekiq/cron/locales/ja.yml".freeze, "lib/sidekiq/cron/locales/ru.yml".freeze, "lib/sidekiq/cron/locales/zh-CN.yml".freeze, "lib/sidekiq/cron/poller.rb".freeze, "lib/sidekiq/cron/support.rb".freeze, "lib/sidekiq/cron/views/cron.erb".freeze, "lib/sidekiq/cron/views/cron.slim".freeze, "lib/sidekiq/cron/views/cron_show.erb".freeze, "lib/sidekiq/cron/views/cron_show.slim".freeze, "lib/sidekiq/cron/web.rb".freeze, "lib/sidekiq/cron/web_extension.rb".freeze, "sidekiq-cron.gemspec".freeze, "test/integration/performance_test.rb".freeze, "test/test_helper.rb".freeze, "test/unit/job_test.rb".freeze, "test/unit/poller_test.rb".freeze, "test/unit/web_extension_test.rb".freeze]
  s.homepage = "http://github.com/ondrejbartas/sidekiq-cron".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.20".freeze
  s.summary = "Sidekiq Cron helps to add repeated scheduled jobs".freeze

  s.installed_by_version = "3.2.20" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sidekiq>.freeze, [">= 4.2.1"])
    s.add_runtime_dependency(%q<fugit>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<redis-namespace>.freeze, [">= 1.5.2"])
    s.add_development_dependency(%q<shoulda-context>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack>.freeze, [">= 0"])
    s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_development_dependency(%q<sdoc>.freeze, [">= 0"])
    s.add_development_dependency(%q<slim>.freeze, [">= 0"])
    s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_development_dependency(%q<shotgun>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard>.freeze, [">= 0"])
    s.add_development_dependency(%q<guard-minitest>.freeze, [">= 0"])
  else
    s.add_dependency(%q<sidekiq>.freeze, [">= 4.2.1"])
    s.add_dependency(%q<fugit>.freeze, ["~> 1.1"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<redis-namespace>.freeze, [">= 1.5.2"])
    s.add_dependency(%q<shoulda-context>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<sdoc>.freeze, [">= 0"])
    s.add_dependency(%q<slim>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<shotgun>.freeze, [">= 0"])
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<guard-minitest>.freeze, [">= 0"])
  end
end
