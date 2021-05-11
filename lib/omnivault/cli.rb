require 'thor'
require 'omnivault'
require 'shellwords'

module Omnivault
  class CLI < Thor
    include Thor::Actions

    # Forward return codes on failures.
    def self.exit_on_failure?
      true
    end

    def self.default_options
      option :vault, aliases: '-v', default: 'default'
    end

    def self.default_option_desc
      '[-v VAULT]'
    end

    desc "set #{default_option_desc} KEY1=value1 [KEY2=value2 ...]",
         'Set one or more secret values in vault'
    default_options
    def set(*args)
      raise ArgumentError, 'Wrong number of arguments' if args.empty?

      hash = Hash[args.map { |arg| arg.split('=', 2) }]
      hash.each do |key, value|
        vault_by_name(options[:vault]).store(key, value)
      end
    end

    desc "unset #{default_option_desc} KEY1 [KEY2 ...]",
         'Unset one or more secret values in vault'
    default_options
    def unset(*args)
      raise ArgumentError, 'Wrong number of arguments' if args.empty?

      vault = vault_by_name(options[:vault])
      missing = args - vault.entries.keys
      raise Thor::Error, "Keys not found: #{missing.join(', ')}" if missing.any?

      args.each do |key|
        vault.remove(key)
      end
    end

    desc "env #{default_option_desc}",
         'Print secret values from vault as source-able ENV variables'
    default_options
    def env
      vault_by_name(options[:vault]).entries.each do |key, value|
        say "#{key}=#{Shellwords.escape(value)}"
      end
    end

    desc "exec #{default_option_desc} COMMAND",
         'Execute command with secret values as ENV variables'
    default_options
    def exec(*args)
      vault_by_name(options[:vault]).entries.each do |key, value|
        ENV[key] = value
      end
      system(*args)
    end

    desc "ls #{default_option_desc}",
         'List all secret keys from vault'
    default_options
    def ls
      vault_by_name(options[:vault]).entries.keys.each do |key|
        say key
      end
    end

    private

    def vault_by_name(name)
      @vaults ||= {}
      @vaults[name] ||= Omnivault.autodetect(name)
    end
  end
end
