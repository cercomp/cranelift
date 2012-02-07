require 'svn/client'

module CraneLift

  class SvnScm
    def initialize
      @ctx = Svn::Client::Context.new
      @ctx.add_simple_provider
      @ctx.add_ssl_server_trust_file_provider
    end

    def checkout(url, destination)
      @ctx.checkout(url, destination)
    end

    def update(path, rev)
      @ctx.update(path, rev)
    end

    def log(paths, start_rev, end_rev, limit)
      logs = []
      @ctx.log(paths, start_rev, end_rev, limit, true, nil) do |changed_paths, rev, author, date, message|
        logs << [changed_paths, rev, author, date, message]
      end
      logs
    end

  end

end
