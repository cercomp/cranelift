# refecence: http://www.ruby-doc.org/stdlib-1.9.3/libdoc/ipaddr/rdoc/index.html
require 'ipaddr'

class Ip < ActiveRecord::Base
  before_save :init_cidr
  
  # reference to validate ip format: http://www.regular-expressions.info/examples.html
  validates :ip,
            :presence => :true
  validates :cidr,
            :numericality => { :greater_than => 0, :less_than => 33 },
            :unless => 'cidr.blank?'
  
  validate :ip_valid_format
  
  def ip_valid_format
    # reference http://www.ruby-doc.org/stdlib-1.9.3/libdoc/ipaddr/rdoc/IPSocket.html
    if /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\Z/ =~ self.ip
      unless $~.captures.all? {|i| i.to_i < 256}
        errors.add(:ip, I18n.t('errors.messages.invalid_ip'))
      end
    else
        errors.add(:ip, I18n.t('errors.messages.invalid_ip'))
    end
  end
  
  def allowed? (ip)
    # ip to long
    ip = IPAddr.new(ip).to_i
    
    min = IPAddr.new(self.ip).to_i
    max = min + (1 << (32 - self.cidr.to_i))
    
    ip >= min and ip < max
  end
  
  private
  def init_cidr
    self.cidr = 32 if self.cidr.blank?
  end
end
