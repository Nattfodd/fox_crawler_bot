module TelegramNotifier
  module Listeners
    class SubscriptionsList < Base

      COMMAND = /мои\s+подписки|подписки/i

      def perform
        subscriptions = Repositories::Subscriptions.get_subscriptions(user_id)
        if subscriptions.none?
          API.send_message(user_id, "Вы еще ни на что не подписаны. "\
            "Напишите мне 'следи за <ссылка>' для создания первой подписки")
          return true
        end

        API.send_message(user_id, "Вы подписаны на следующие обновления:")
        subscriptions.each do |sub|
          API.send_message(user_id, sub.url, disable_web_page_preview: true)
        end
        true
      end
    end
  end
end
