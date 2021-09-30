if Rails.env.production?
  raise "Can't run seeds on production DB because it'll destroy data"
end

User.delete_all
People::Person.delete_all
Connections::Connection.delete_all
Teams::Team.delete_all
Assignments::Assignment.delete_all

User.create(first_name: "30", last_name: "Rock", email: "demo@30rock.com", admin: true, password: 'password', password_confirmation: 'password')
User.create(first_name: "Marvel", last_name: "Comics", email: "demo@mcu.com", admin: true, password: 'password', password_confirmation: 'password')

load File.join(Rails.root, 'db', 'seeds', '30rock.rb')
load File.join(Rails.root, 'db', 'seeds', 'MCU.rb')
