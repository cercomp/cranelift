require 'svn/client'

module CraneLift

  class SvnScm
    @@ctx = Svn::Client::Context.new

    class << self
      def checkout(url, destination)
        @@ctx.add_simple_provider
        @@ctx.add_ssl_server_trust_file_provider
        @@ctx.checkout(url, destination)
      end
    end

  end

end
