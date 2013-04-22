module EnvironmentHelper
  def self.route(url)
    user = `whoami`.strip
    "/~#{user}/app/#{url}"
  end
end
