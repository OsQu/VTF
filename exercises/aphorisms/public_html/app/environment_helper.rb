module EnvironmentHelper
  def self.me
    `whoami`.strip
  end

  def self.route(url)
    "/~#{self.me}/app/#{url}"
  end

  def self.static_root
    "/~#{self.me}/static"
  end
end
