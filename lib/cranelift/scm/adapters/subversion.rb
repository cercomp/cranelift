module Cranelift::Scm::Adapters

  class Subversion
    attr_accessor :ctx

    def initialize
      self.ctx = ::Svn::Client::Context.new
      self.ctx.add_simple_provider
      self.ctx.add_ssl_server_trust_file_provider
    end

    def checkout(url, destination)
      url = remove_last_slash(url)
      ctx.checkout(url, destination)
    end

    def update(path, rev)
      ctx.update(path, rev)
    end

    def log(paths, start_rev, end_rev, limit)
      logs = []
      ctx.log(paths, start_rev, end_rev, limit, true, nil) do |changed_paths, rev, author, date, message|
        logs << [changed_paths, rev, author, date, message]
      end
      logs
    end

    def info(repo_path)
      repo_path = remove_last_slash(repo_path) if repo_path.is_a? String
      begin
        @info
        ctx.info(repo_path) do |path, info|
          @info = info
        end
        @info
      rescue Svn::Error::SvnError
        return nil
      end
    end

    def export(from, to, revision)
      ctx.export(from, to, revision)
    end

    def remove_last_slash(s)
      return (s[-1] == '/') ? s[0...-1] : s
    end

  end
end
