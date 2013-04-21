namespace :exercises do
  desc "Add exercises to database"
  task :db_data => :environment do
    sqli = Category.create name: "SQL Injection"
    sqli.exercises << Exercise.create(name: "Acme Vault", description: "TODO: Markdown description")
  end
end
