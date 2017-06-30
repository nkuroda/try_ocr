module TryOcr
  class Receipt
    attr_reader :image

    def initialize(source)
      @image = RTesseract.new(source, lang: 'eng+jpn')
    end

    # OCRで読み取った全文を返す
    def text
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
  end
end
