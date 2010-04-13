# DO NOT MODIFY THIS FILE
# Generated by Bundler 0.9.18

require 'digest/sha1'
require 'rubygems'
require 'pathname'

module Gem
  class Dependency
    if !instance_methods.map { |m| m.to_s }.include?("requirement")
      def requirement
        version_requirements
      end
    end
  end
end

module Bundler
  module SharedHelpers
    attr_accessor :gem_loaded

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "Could not locate Gemfile"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

    def env_file
      default_gemfile.dirname.join(".bundle/environment.rb")
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("..", current), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def cripple_rubygems(specs)
      reverse_rubygems_kernel_mixin

      executables = specs.map { |s| s.executables }.flatten
      Gem.source_index # ensure RubyGems is fully loaded

     ::Kernel.class_eval do
        private
        def gem(*) ; end
      end

      ::Kernel.send(:define_method, :gem) do |dep, *reqs|
        if executables.include? File.basename(caller.first.split(':').first)
          return
        end
        opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

        unless dep.respond_to?(:name) && dep.respond_to?(:requirement)
          dep = Gem::Dependency.new(dep, reqs)
        end

        spec = specs.find  { |s| s.name == dep.name }

        if spec.nil?
          e = Gem::LoadError.new "#{dep.name} is not part of the bundle. Add it to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        elsif dep !~ spec
          e = Gem::LoadError.new "can't activate #{dep}, already activated #{spec.full_name}. " \
                                 "Make sure all dependencies are added to Gemfile."
          e.name = dep.name
          e.version_requirement = dep.requirement
          raise e
        end

        true
      end

      # === Following hacks are to improve on the generated bin wrappers ===

      # Yeah, talk about a hack
      source_index_class = (class << Gem::SourceIndex ; self ; end)
      source_index_class.send(:define_method, :from_gems_in) do |*args|
        source_index = Gem::SourceIndex.new
        source_index.spec_dirs = *args
        source_index.add_specs(*specs)
        source_index
      end

      # OMG more hacks
      gem_class = (class << Gem ; self ; end)
      gem_class.send(:define_method, :bin_path) do |name, *args|
        exec_name, *reqs = args

        spec = nil

        if exec_name
          spec = specs.find { |s| s.executables.include?(exec_name) }
          spec or raise Gem::Exception, "can't find executable #{exec_name}"
        else
          spec = specs.find  { |s| s.name == name }
          exec_name = spec.default_executable or raise Gem::Exception, "no default executable for #{spec.full_name}"
        end

        gem_bin = File.join(spec.full_gem_path, spec.bindir, exec_name)
        gem_from_path_bin = File.join(File.dirname(spec.loaded_from), spec.bindir, exec_name)
        File.exist?(gem_bin) ? gem_bin : gem_from_path_bin
      end
    end

    extend self
  end
end

module Bundler
  LOCKED_BY    = '0.9.18'
  FINGERPRINT  = "7ceebc64ce41beb211f1dee7b6fa4cb6b9ee5418"
  AUTOREQUIRES = {:test=>[["cucumber", false], ["factory_girl", false], ["mocha", false], ["pickle", false], ["rspec", false], ["rspec-rails", false], ["test-unit", false], ["webrat", false]], :default=>[["acl9", false], ["acts_as_list", true], ["mime/types", true], ["aws/s3", true], ["delayed_job", false], ["formtastic", false], ["haml", false], ["inherited_resources", false], ["mongrel", false], ["mysql", false], ["pg", false], ["publishable", false], ["rails", false], ["zip/zip", true], ["sqlite3", true]], :development=>[["bullet", false], ["rails-footnotes", false]], :cucumber=>[["cucumber", false], ["factory_girl", false], ["mocha", false], ["pickle", false], ["rspec", false], ["rspec-rails", false], ["test-unit", false], ["webrat", false]]}
  SPECS        = [
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249%global/specifications/rake-0.8.7.gemspec", :name=>"rake", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249%global/gems/rake-0.8.7/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/acl9-0.12.0.gemspec", :name=>"acl9", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/acl9-0.12.0/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/activesupport-2.3.5.gemspec", :name=>"activesupport", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/activesupport-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rack-1.0.1.gemspec", :name=>"rack", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rack-1.0.1/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/actionpack-2.3.5.gemspec", :name=>"actionpack", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/actionpack-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/actionmailer-2.3.5.gemspec", :name=>"actionmailer", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/actionmailer-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/activerecord-2.3.5.gemspec", :name=>"activerecord", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/activerecord-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/activeresource-2.3.5.gemspec", :name=>"activeresource", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/activeresource-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/acts-as-list-0.1.2.gemspec", :name=>"acts-as-list", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/acts-as-list-0.1.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/builder-2.1.2.gemspec", :name=>"builder", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/builder-2.1.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/mime-types-1.16.gemspec", :name=>"mime-types", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mime-types-1.16/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/xml-simple-1.0.12.gemspec", :name=>"xml-simple", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/xml-simple-1.0.12/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/aws-s3-0.6.2.gemspec", :name=>"aws-s3", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/aws-s3-0.6.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/bullet-1.7.3.gemspec", :name=>"bullet", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/bullet-1.7.3/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/diff-lcs-1.1.2.gemspec", :name=>"diff-lcs", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/diff-lcs-1.1.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/polyglot-0.2.9.gemspec", :name=>"polyglot", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/polyglot-0.2.9/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/term-ansicolor-1.0.4.gemspec", :name=>"term-ansicolor", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/term-ansicolor-1.0.4/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/treetop-1.4.2.gemspec", :name=>"treetop", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/treetop-1.4.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/cucumber-0.4.4.gemspec", :name=>"cucumber", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/cucumber-0.4.4/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/daemons-1.0.10.gemspec", :name=>"daemons", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/daemons-1.0.10/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/delayed_job-2.0.2.gemspec", :name=>"delayed_job", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/delayed_job-2.0.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/factory_girl-1.2.3.gemspec", :name=>"factory_girl", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/factory_girl-1.2.3/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/formtastic-0.9.8.gemspec", :name=>"formtastic", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/formtastic-0.9.8/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/gem_plugin-0.2.3.gemspec", :name=>"gem_plugin", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/gem_plugin-0.2.3/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/haml-2.2.23.gemspec", :name=>"haml", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/haml-2.2.23/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/has_scope-0.5.0.gemspec", :name=>"has_scope", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/has_scope-0.5.0/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/json_pure-1.2.4.gemspec", :name=>"json_pure", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/json_pure-1.2.4/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rubyforge-2.0.4.gemspec", :name=>"rubyforge", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rubyforge-2.0.4/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/hoe-2.6.0.gemspec", :name=>"hoe", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/hoe-2.6.0/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/responders-0.4.7.gemspec", :name=>"responders", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/responders-0.4.7/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/inherited_resources-1.0.6.gemspec", :name=>"inherited_resources", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/inherited_resources-1.0.6/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/mocha-0.9.8.gemspec", :name=>"mocha", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mocha-0.9.8/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/mongrel-1.1.6.gemspec", :name=>"mongrel", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mongrel-1.1.6/lib", "/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mongrel-1.1.6/ext"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/mysql-2.8.1.1.gemspec", :name=>"mysql", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mysql-2.8.1.1/lib", "/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/mysql-2.8.1.1/ext"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/nokogiri-1.4.1.gemspec", :name=>"nokogiri", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/nokogiri-1.4.1/lib", "/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/nokogiri-1.4.1/ext"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/pg-0.9.0.gemspec", :name=>"pg", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/pg-0.9.0/lib", "/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/pg-0.9.0/ext"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/pickle-0.2.1.gemspec", :name=>"pickle", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/pickle-0.2.1/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/publishable-0.1.3.gemspec", :name=>"publishable", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/publishable-0.1.3/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rails-2.3.5.gemspec", :name=>"rails", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rails-2.3.5/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rails-footnotes-3.6.6.gemspec", :name=>"rails-footnotes", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rails-footnotes-3.6.6/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rspec-1.3.0.gemspec", :name=>"rspec", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rspec-1.3.0/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rspec-rails-1.3.2.gemspec", :name=>"rspec-rails", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rspec-rails-1.3.2/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/rubyzip-0.9.4.gemspec", :name=>"rubyzip", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/rubyzip-0.9.4/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/sqlite3-ruby-1.2.5.gemspec", :name=>"sqlite3-ruby", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/lib", "/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/sqlite3-ruby-1.2.5/ext"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/test-unit-1.2.3.gemspec", :name=>"test-unit", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/test-unit-1.2.3/lib"]},
        {:loaded_from=>"/Users/martin/.rvm/gems/ruby-1.8.7-p249/specifications/webrat-0.6.0.gemspec", :name=>"webrat", :load_paths=>["/Users/martin/.rvm/gems/ruby-1.8.7-p249/gems/webrat-0.6.0/lib"]},
      ].map do |hash|
    if hash[:virtual_spec]
      spec = eval(hash[:virtual_spec], binding, "<virtual spec for '#{hash[:name]}'>")
    else
      dir = File.dirname(hash[:loaded_from])
      spec = Dir.chdir(dir){ eval(File.read(hash[:loaded_from]), binding, hash[:loaded_from]) }
    end
    spec.loaded_from = hash[:loaded_from]
    spec.require_paths = hash[:load_paths]
    spec
  end

  extend SharedHelpers

  def self.configure_gem_path_and_home(specs)
    # Fix paths, so that Gem.source_index and such will work
    paths = specs.map{|s| s.installation_path }
    paths.flatten!; paths.compact!; paths.uniq!; paths.reject!{|p| p.empty? }
    ENV['GEM_PATH'] = paths.join(File::PATH_SEPARATOR)
    ENV['GEM_HOME'] = paths.first
    Gem.clear_paths
  end

  def self.match_fingerprint
    print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))
    unless print == FINGERPRINT
      abort 'Gemfile changed since you last locked. Please `bundle lock` to relock.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    clean_load_path
    cripple_rubygems(SPECS)
    configure_gem_path_and_home(SPECS)
    SPECS.each do |spec|
      Gem.loaded_specs[spec.name] = spec
      spec.require_paths.each do |path|
        $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
      end
    end
    self
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group.to_sym] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  # Set up load paths unless this file is being loaded after the Bundler gem
  setup unless gem_loaded
end
