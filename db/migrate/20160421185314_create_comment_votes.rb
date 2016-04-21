class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.belongs_to :politician, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.boolean :user_vote, null: false

      t.timestamps null: false
    end
  end
end
