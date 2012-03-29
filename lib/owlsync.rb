$:.unshift File.dirname(__FILE__)

module Owlsync
  autoload :Configurable, 'owlsync/configurable'
  autoload :Strategy, 'owlsync/strategy'
  autoload :Resource, 'owlsync/resource'
  autoload :Worker, 'owlsync/worker'
  autoload :Server, 'owlsync/server'

  include Configurable

  def self.strategies
    @@strategies ||= []
  end
end
