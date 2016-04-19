class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :body, null: false
      t.belongs_to :politician, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
