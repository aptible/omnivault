module Omnivault
  class PWS < AbstractVault
    attr_accessor :cli, :raw_data

    def initialize(name = 'default')
      require 'pws'

      @cli ||= ::PWS.new(namespace: name)
      @raw_data = @cli.instance_variable_get(:@data)
    end

    def entries
      Hash[raw_data.map { |k, v| [k, v[:password]] }]
    end

    def store(key, value)
      cli.add(key, value)
    end

    def remove(key)
      cli.remove(key)
    end
  end
end
