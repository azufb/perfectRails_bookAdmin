class Publisher < ApplicationRecord
    # 1対多
    # Publisherモデルにbooksというメソッドを定義
    # booksメソッドを通して、Booksモデルの情報を取得したり、モデル間の関連を追加したりできる
    has_many :books
end
