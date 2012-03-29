require 'daemons'

module Owlsync
  class Server
    def initialize(args = nil)
      @options = { pid_dir: 'pids' }
      @args = args
    end 
    
    def daemonize
      dir = @options[:pid_dir]
      Dir.mkdir(dir) unless File.exists?(dir)

      process_name = 'owlsync'
      run_process(process_name, dir)
    end

    def run_process(process_name, dir)
      Daemons.run_proc(process_name, dir: dir, dir_mode: :normal, monitor: true, ARGV: @args, log_output: true) do
        run process_name
      end
    end

    def run(process_name = nil)
      config = Owlsync.config
      worker = Worker.new(config.worker_type, config.worker_options)
      worker.process_name = process_name
      worker.start 
    end
  end
end
