module AtCoderProblems
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  module Request
    class ContestsRequest < APIRequest
      class << self
        def built_in
          base_url = 'https://kenkoooo.com/atcoder/resources/'
          base_url + 'contests.json'
        end
      end
    end
  end
end
