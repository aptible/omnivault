require 'omnivault/version'

require_relative 'omnivault/abstract_vault'
require_relative 'omnivault/apple_keychain'
require_relative 'omnivault/pws'

module Omnivault
  def self.autodetect
    Omnivault::AbstractVault.from_env || Omnivault::AbstractVault.for_platform
  end
end
