module AtCoderProblems
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  class APIRequest
    class << self
      def build
        self.built_in
      end

      def built_in
        raise NotImplementedError
      end
    end
  end
end
