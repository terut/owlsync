require 'singleton'

module Owlsync
  module Configurable
    class Configuration
      include Singleton

      @@defaults = {
        worker_type: :ec2,
        worker_options: {},
        ssh_key: '~/.ssh/id_rsa',
        ssh_user: 'ec2-user',
        source_path: '/path/to/source',
        release_path: '/path/to/release',
        rsync_options: '-azv',
        interval: 60
      }
      
      def self.defaults
        @@defaults
      end

      def initialize
        @@defaults.each_pair { |k,v| __send__("#{k}=", v) }
      end
     
      def to_hash
        @hash ||= @@defaults.keys.inject({}) { |h, k| h[k] = __send__("k") }
      end

      attr_accessor *(@@defaults.keys)
    end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def config
        Configuration.instance
      end

      def configure
        yield config
      end
    end
  end
end
