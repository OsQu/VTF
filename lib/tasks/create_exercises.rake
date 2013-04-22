namespace :exercises do
  # Markdown descriptions. These should be moved to some proper place
  acmevault_desc = "
Acme Vault is a website where one can store and fetch secrets she or he
may posess.

Your task is simply to reveal everyone else's secrets. Note that usually
you're only able to see your own secrets, and even then you need to
remember the name for which you saved the secret! Oh I wish there is some
way around the limitation.."
  desc "Add exercises to database"
  task :db_data => :environment do
    sqli = Category.create name: "SQL Injection"
    acmevault_md = RDiscount.new(acmevault_desc)
    sqli.exercises << Exercise.create(name: "Acme Vault", parameterized_name: "acmevault",
      description: acmevault_md.to_html,
      sources: "app.rb, environment_helper.rb, views/find.haml, views/index.haml, views/layout.haml, views/stored.haml")
  end

  desc "Compile source code hilights to database"
  task :source_code => :environment do
    Exercise.all.each do |e|
      e.compile_source_codes
    end
  end

  desc "Remove all the exercises and categories"
  task :remove_db_data => :environment do
    # TODO: Cleanup sandboxes on destroy!
    Category.all.each { |c| c.destroy }
    Exercise.all.each { |e| e.destroy }
  end
end
