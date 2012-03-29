module Owlsync
  module Strategy
    def self.included(base)
      Owlsync.strategies << base

      base.class_eval do
        attr_accessor :client
      end
    end

    def self.service(name, options)
      begin
        require "owlsync/strategies/#{name.to_s}"
        Owlsync::Strategies.const_get("#{name.capitalize}").new(options)
      rescue NameError
        raise LoadError, "Could not find matching strategy for #{name}. You may need check service."
      end
    end

    def resources
      crawl!
    end
    
    private
    def crawl!; p "Please return { instance_id: dns_name }."; end
  end
end
