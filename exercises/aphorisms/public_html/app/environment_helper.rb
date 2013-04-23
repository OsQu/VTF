module EnvironmentHelper
  def self.route(url)
    user = `whoami`.strip
    "/~#{user}/app/#{url}"
  end

  def self.me
    `whoami`.strip
  end
end
