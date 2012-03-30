require 'aws-sdk'

module Owlsync
  module Strategies
    class Ec2
      include Strategy 

      attr_accessor :tag

      def initialize(options)
        self.tag = options.delete(:tag)
        self.client = ::AWS::EC2.new(options)
      end
      
      private

      def crawl!
        client.instances.inject({}) { |h, i| h[i.id] = i.private_dns_name if target?(i); h } 
      end

      def target?(instance)
        instance.tags[tag[:key]] == tag[:value]
      end
    end
  end
end
