# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create 10 users
users = [
  { first_name: "Roy", last_name: "Mustang", email: "roy@fma.com", password: "roymustang" },
  { first_name: "Rintaro", last_name: "Okabe", email: "okabe@gate.com", password: "rintarookabe" },
  { first_name: "Caped", last_name: "Baldy", email: "saitama@opm.com", password: "capedbaldy" },
  { first_name: "Lelouch", last_name: "Lamperouge", email: "lelouch@geass.com", password: "lelouchlamperouge" },
  { first_name: "Monkey D.", last_name: "Luffy", email: "luffy@strawhat.com", password: "monkeydluffy" },
  { first_name: "Edward", last_name: "Elric", email: "edward@alchemy.com", password: "edwardelric" },
  { first_name: "Naruto", last_name: "Uzumaki", email: "naruto@hokage.com", password: "narutouzumaki" },
  { first_name: "Spike", last_name: "Spiegel", email: "spike@bebop.com", password: "spikespiegel" },
  { first_name: "Gon", last_name: "Freecss", email: "gon@hunt.com", password: "gonfreecss" },
  { first_name: "Kaneki", last_name: "Ken", email: "kaneki@ghoul.com", password: "kanekiken" }
]

# Create 10 posts with quotes
quotes = [
  "The world isn’t perfect. But it’s there for us, doing the best it can. That’s what makes it so damn beautiful.",
  "I will always love you, no matter which what time, or where I am. I’ll say it one more time. I love you.",
  "I’ll leave tomorrow’s problems to tomorrow’s me.",
  "I, Lelouch vi Britannia, command you!",
  "I'm going to be the Pirate King!",
  "A lesson without pain is meaningless. For you cannot gain something without sacrificing something else in return.",
  "I'm not gonna run away, I never go back on my word! That's my nindo: my ninja way!",
  "I'm not going there to die. I'm going to find out if I'm really alive.",
  "If you want to get to know someone, find out what makes them angry.",
  "It's not the world that's messed up; it's those of us in it."
]

# Create 10 comments
comments = [
  "This comment was made by Roy Mustang (Full Metal Alchemist)",
  "This comment was made by Okabe (Steins; Gate)",
  "This comment was made by Saitama (One-Punch Man)",
  "This comment was made by Lelouch Lamperouge (Code Geass)",
  "This comment was made by Monkey D. Luffy (One Piece)",
  "This comment was made by Edward Elric (Full Metal Alchemist)",
  "This comment was made by Naruto Uzumaki (Naruto)",
  "This comment was made by Spike Spiegel (Cowboy Bebop)",
  "This comment was made by Gon Freecss (Hunter x Hunter)",
  "This comment was made by Kaneki Ken (Tokyo Ghoul)"
]

servers = [
  {
    identifier: "kurustudio",
    domains: ["kuru.studio", "server.kuru.studio", "social.kuru.studio"],
    features: ["blog"],
  },
  {
    identifier: "purrintables",
    domains: ["purrintables.com"],
    features: ["blog"],
  },
  {
    identifier: "boseriko",
    domains: ["boseriko.com"],
    features: ["blog"],
  },
]

# Create servers
servers.each_with_index do |server, index|
  created_server = Server.new(server)
  created_server.save!
end

# Create users
users.each_with_index do |user, index|
  created_user = User.new()
  created_user.email = user[:email]
  created_user.password = user[:password]
  created_user.save!
end

# Create members
User.all.each_with_index do |user, index|
  created_member = Member.new()
  created_member.server_id = Server.find_by(identifier: "kurustudio").id
  created_member.user_id = user.id
  created_member.save!
end