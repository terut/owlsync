module Owlsync
  class Resource
    attr_accessor :dns_name, :user_name, :identityfile, :rsync_options, :updated, :release_path
    attr_reader  :source_path

    def initialize(dns_name)
      config = Owlsync.config
      self.dns_name = dns_name
      self.identityfile = config.ssh_key
      self.user_name = config.ssh_user
      self.rsync_options = config.rsync_options
      self.source_path = config.source_path
      self.release_path = config.release_path
      self.updated = false
    end

    def source_path=(path)
      @source_path =  path_fixed(path)
    end

    def rsync
      now = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      unless updated?
        cmd = "rsync #{rsync_options} -e 'ssh -i #{identityfile}' #{source_path} #{user_name}@#{dns_name}:#{release_path}"
        self.updated = system(cmd)

        $stdout.puts "[#{now}]: #{cmd}"
      else
        $stdout.puts "[#{now}]: Already updated."
      end
    rescue => e
      $stderr.puts "[#{now}][Error]: #{e}"
    end

    private

    def path_fixed(path)
      path.end_with?("/") ? path : "#{path}/"  
    end
    
    def updated?
      updated
    end
 end
end
