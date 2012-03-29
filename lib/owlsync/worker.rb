module Owlsync
  class Worker
    attr_accessor :process_name, :service, :resources

    def initialize(name, options)
      self.service = Strategy.service(name, options)
      self.resources = {}
    end

    def start
      loop do
        refresh!
        resources.each do |k, resource|
          resource.rsync
        end
        sleep Owlsync.config.interval
      end
    end

    private

    def refresh!
      current = service.resources
      resources.reject! { |k, resource| !current.key?(k) }
      current.each do |k, dns_name|
        resources[k] = Resource.new(dns_name) unless resources.key?(k)
      end
    end
  end
end
