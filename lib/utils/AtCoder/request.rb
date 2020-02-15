module AtCoder
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  module Request
    class StandingsRequest < APIRequest
      class << self
        def built_in(builtin)
          contest_id = builtin[:contest_id]
          url = "https://atcoder.jp/contests/#{contest_id}/standings/json"

          {
            contest_id: contest_id,
            url:        url
          }
        end
      end
    end

    class VirtualStandingsRequest < APIRequest
      class << self
        def built_in(builtin)
          contest_id = builtin[:contest_id]
          url = "https://atcoder.jp/contests/#{contest_id}/standings/virtual/json"

          {
            contest_id: contest_id,
            url:        url
          }
        end
      end
    end
  end
end
