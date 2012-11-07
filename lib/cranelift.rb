require 'net/https'
require 'svn/client'

require 'cranelift/scm'
require 'cranelift/auth'

ApplicationController.send(:include, Cranelift::Auth)

module Cranelift
end
