module AtCoder
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  class APIRequest
    class << self
      def build(contest_id)
        self.built_in({contest_id: contest_id})
      end

      def built_in(builtin)
        raise NotImplementedError
      end
    end
  end
end
