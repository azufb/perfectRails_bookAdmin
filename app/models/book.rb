class Book < ApplicationRecord
    # Scopeとは、よく利用する検索条件に名前を付けてまとめたもの。
    # Scopeを利用することで、クエリの再利用性が上がったり、クエリに名前が付いて可読性が上がる。
    # チェインで重ねて呼び出すことも可能。

    # ここではcostlyという名前を付けた。
    # priceが3000円以上のレコードを検索。
    scope :costly, -> { where("price > ?", 3000) }

    # written_about
    # チェインを利用した場合には、前の結果を引数themeとして受け取り、nameに指定した文字列が含まれるレコードを検索。
    scope :written_about, ->(theme) { where("name like ?", "%#{theme}%") }

    # 1対多
    # Bookモデルにpublisherというメソッドを定義
    # publisherメソッドを通して、Publisherモデルの情報を取得したり、モデル間の関連を追加したりできる
    belongs_to :publisher
    has_many :book_authors
    # through:で中間テーブルを指定
    has_many :authors, through: :book_authors

    validates :name, presence: true
    validates :name, length: { maximum: 25 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }

    # 組み込みのバリデーションではなく、より複雑なバリデーションを行う場合には、validateブロック内で独自のバリデーションを行う。
    validate do |book|
        if book.name.include?("exercise")
            book.errors[:name] << "I don't like exercise."
        end
    end
end
