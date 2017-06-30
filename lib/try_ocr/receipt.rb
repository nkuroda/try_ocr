module TryOcr
  class Receipt
    attr_reader :image

    def initialize(source)
      @image = Google::Cloud::Vision.new.image(source)
    end

    # OCRで読み取った全文を返す
    def full_text
      words.map(&:text).join.strip
    end

    # レシートの日付を返す。認識できなければnilを返す
    def date
    end

    # レシートの金額を返す。認識できなければnilを返す
    def amount
    end

    # レシートの電話番号を返す。認識できなければnilを返す
    def tel
    end

    private

    # 単語の配列
    def words
      @words ||= image.text&.words
    end
  end
end
