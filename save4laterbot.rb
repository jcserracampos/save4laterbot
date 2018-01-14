require 'telegram/bot'

token = File.read(".telegram_token").strip

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|

        puts message.text
        puts message.from.username
        puts message.chat.title


        links = message.text.split(/\s+/).find_all { |u| u =~ /^https?:/ }
    end
end