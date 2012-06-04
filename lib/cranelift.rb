require 'net/https'
require 'svn/client'

module Cranelift

  class SvnScm
    def initialize
      @ctx = Svn::Client::Context.new
      @ctx.add_simple_provider
      @ctx.add_ssl_server_trust_file_provider
    end

    def checkout(url, destination)
      url = remove_last_slash(url)
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

    def info(repo_path)
      repo_path = remove_last_slash(repo_path) if repo_path.is_a? String
      begin
        @info
        @ctx.info(repo_path) do |path, info|
          @info = info
        end
        @info
      rescue Svn::Error::SvnError
        return nil
      end
    end

    def export(from, to, revision)
      @ctx.export(from, to, revision)
    end

    def remove_last_slash(s)
      s = s[0...-1] if (s[-1] == '/')
      s
    end

  end

end
