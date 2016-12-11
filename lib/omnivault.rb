require 'omnivault/version'

require_relative 'omnivault/abstract_vault'
require_relative 'omnivault/apple_keychain'
require_relative 'omnivault/pws'

module Omnivault
  def self.autodetect(name = 'default')
    Omnivault::AbstractVault.from_env(name) ||
      Omnivault::AbstractVault.for_platform(name)
  end
end
