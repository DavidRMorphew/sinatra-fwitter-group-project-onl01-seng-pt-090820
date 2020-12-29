class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  def slug
    self.username.scan(/[a-zA-Z\s0-9]/).join("").gsub(" ","-").downcase
  end
  def self.find_by_slug(slugified_name)
    self.all.detect {|item| item.slug == slugified_name}
  end
end
