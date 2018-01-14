require 'telegram/bot'
require "sqlite3"

token = File.read(".telegram_token").strip

# db = SQLite3::Database.new "urls.db"
# db.execute "CREATE TABLE IF NOT EXISTS Links(link TEXT, 
#         author TEXT, groupt TEXT)"

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|

        puts message.text
        puts message.from.username
        puts message.chat.title


        output = message.text.split(/\s+/).find_all { |u| u =~ /^https?:/ }

        # puts output
    end
end