require 'telegram/bot'
require 'pg'

if ENV["MY_TOKEN"]
    token = ENV["MY_TOKEN"]
else
    token = File.read(".telegram_token").strip
end

db = PG.connect(ENV["DATABASE_URL"])
db.exec "CREATE TABLE IF NOT EXISTS Links(Link VARCHAR(255), Author VARCHAR(30), Chat VARCHAR(30))"

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        links = message.text.split(/\s+/).find_all { |u| u =~ /^https?:/ }

        links.each do |link|
            db.exec "INSERT INTO Links VALUES('#{link}', '#{message.from.username}', '#{message.chat.title}')"
        end
      
    end
end