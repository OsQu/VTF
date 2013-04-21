namespace :exercises do
  # Markdown descriptions. These should be moved to some proper place
  sqli_desc = "
Avatar Vault is a website where one can store and fetch secrets she or he
may posess.

Your task is simply to reveal everyone else's secrets. Note that usually
you're only able to see your own secrets, and even then you need to
remember the name for which you saved the secret! Oh I wish there is some
way around the limitation.."
  desc "Add exercises to database"
  task :db_data => :environment do
    sqli = Category.create name: "SQL Injection"
    sqli_md = RDiscount.new(sqli_desc)
    sqli.exercises << Exercise.create(name: "Acme Vault", parameterized_name: "acmevault",
      description: sqli_md.to_html)
  end

  desc "Remove all the exercises and categories"
  task :remove_db_data => :environment do
    # TODO: Cleanup sandboxes on destroy!
    Category.all.each { |c| c.destroy }
    Exercise.all.each { |e| e.destroy }
  end
end
