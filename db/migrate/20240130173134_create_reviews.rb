class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.bigint :buyer_id
      t.bigint :seller_id
      t.bigint :product_id

      t.timestamps
    end
  end
end
