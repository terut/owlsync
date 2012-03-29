module Owlsync
  module Strategies
    class Fixed
      include Strategy

      attr_accessor :servers

      def initialize(options)
        self.servers = options[:servers]
      end

      private

      def crawl!
        servers
      end
    end
  end
end
