require 'telegram/bot'
require 'pg'

if ENV["MY_TOKEN"]
    token = ENV["MY_TOKEN"]
else
    token = File.read(".telegram_token").strip
end

# db = PG.connect(ENV["DATABASE_URL"])
db = PG.connect("postgres://hcxrdxyfsnsiew:30223d2dae076e7fc6cda7efd321981a071cf15ead5987b1987edbde200cb5cb@ec2-54-221-251-195.compute-1.amazonaws.com:5432/d2pinu54s5arm0")
db.exec "CREATE TABLE IF NOT EXISTS Links(Link VARCHAR(255), Author VARCHAR(30), Chat VARCHAR(30))"

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        links = message.text.split(/\s+/).find_all { |u| u =~ /^https?:/ }

        links.each do |link|
            db.exec "INSERT INTO Links VALUES('#{link}', '#{message.from.username}', '#{message.chat.title}')"
        end
      
    end
end