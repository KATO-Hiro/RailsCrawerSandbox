module AtCoderProblems
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  module Client
    class ContestsClient < APIClient
      class << self
        private
          def format(responses)
            contest_list = []

            if responses.present?
              # FIXME: mapメソッドを使って書き直す
              responses.each do |response|
                contest_list <<
                Contest.new(
                  name:               response["id"],
                  start_epoch_second: response["start_epoch_second"],
                  duration_second:    response["duration_second"],
                  title:              response["title"],
                  rate_change:        response["rate_change"]
                )
              end
            end

            contest_list
          end
      end
    end
  end
end
