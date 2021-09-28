if Rails.env.production?
  raise "Can't run seeds on production DB because it'll destroy data"
end

User.delete_all
People::Person.delete_all
Connections::Connection.delete_all
Teams::Team.delete_all
Assignments::Assignment.delete_all

User.create(first_name: "Will", last_name: "Read", email: "will.read@gmail.com", admin: true, password: 'password', password_confirmation: 'password')

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
