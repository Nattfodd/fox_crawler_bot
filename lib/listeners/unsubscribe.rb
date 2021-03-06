module TelegramNotifier
  module Listeners
    class Unsubscribe < Base

      COMMAND = /stop|стоп|прекращай|отпишись|отписка|прекрати|харэ/i

      def perform
        Repositories::Subscriptions.remove_subscriber(user_id)
        API.send_message(user_id, 'Вы успешно отписались от всех рассылок.')
        true
      end
    end
  end
end
