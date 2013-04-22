class Sandbox < ActiveRecord::Base
  attr_accessible :user, :exercise
  belongs_to :user
  belongs_to :exercise

  def url
    "#{ENV['SANDBOX_URL']}/~#{user.username}#{exercise.parameterized_name}/app"
  end

  def copy_env_file
    env_file = File.join(exercise.path, "env")
    if File.exists?(env_file)
      def replace_rand(content)
        if content.count("RAND") == 0
          return content
        else
          random_string = (1..12).map{('a'..'z').to_a[rand(26)]}.join
          content.sub!("RAND", random_string)
          replace_rand(content)
        end
      end

      # TODO: SAVE TO SANDBOX
      content = replace_rand(File.read(env_file))

      FileUtils.mkdir_p env_file_location :only_folder => true
      File.open(env_file_location, 'w') { |f| f.write(content) }
    end
  end

  private

  def env_file_location(options = {})
    filename = "#{user.username}#{exercise.parameterized_name}"
    if options[:only_folder]
      Rails.root.join("tmp", "sandboxenvs")
    else
      Rails.root.join("tmp", "sandboxenvs", filename)
    end
  end
end
