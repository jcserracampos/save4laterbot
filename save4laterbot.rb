require 'telegram/bot'
require 'pg'

if ENV["MY_TOKEN"]
    token = ENV["MY_TOKEN"]
else
    token = File.read(".telegram_token").strip
end

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|

        puts message.text
        puts message.from.username
        puts message.chat.title


        links = message.text.split(/\s+/).find_all { |u| u =~ /^https?:/ }
    end
end