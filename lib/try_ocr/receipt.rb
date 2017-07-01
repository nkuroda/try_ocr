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

    # レシートの金額を返す。認識できなければnilを返す
    def amount
      return if amount_word.nil?

      amount_word.text.to_i
    end

    # レシートの日付を返す。認識できなければnilを返す
    def date
      raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
    end

    # レシートの電話番号を返す。認識できなければnilを返す
    def tel
      raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
    end

    private

    # 単語の配列
    def words
      @words ||= image.text&.words
    end

    # 金額の単語
    def amount_word
      return if amount_label_word.nil?

      amount_row_words.sort_by { |word| word.text.to_i }.last
    end

    # 金額ラベルの単語候補
    def amount_label_word_candidates
      %w(合計)
    end

    # 金額ラベルの単語
    def amount_label_word
      # 金額合計は後にあることが多いので後ろ優先で探索
      words.reverse.find { |word| amount_label_word_candidates.include?(word.text) }
    end

    # 金額ラベルの左上頂点
    def amount_label_word_tl_vertex
      amount_label_word&.bounds&.first
    end

    # 金額ラベルの左下頂点
    def amount_label_word_bl_vertex
      amount_label_word&.bounds&.last
    end

    # 金額行のyレンジ。金額ラベルのy座標レンジとする。
    def amount_row_y_range
      return if amount_label_word.nil?

      amount_label_word_tl_vertex.y..amount_label_word_bl_vertex.y
    end

    # 金額行かどうかの判定メソッド
    def amount_row?(word)
      tl_vertex = word.bounds.first
      bl_vertex = word.bounds.last

      # amount_row_y_rangeとoverlapを見る
      amount_row_y_range.overlaps?(tl_vertex.y..bl_vertex.y)
    end

    # 金額行のwords
    def amount_row_words
      words.select { |word| amount_row?(word) }
    end
  end
end
