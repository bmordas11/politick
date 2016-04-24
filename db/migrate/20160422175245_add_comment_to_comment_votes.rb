class AddCommentToCommentVotes < ActiveRecord::Migration
  def change
    remove_column :comment_votes, :politician_id, :integer, index: true, foreign_key: true, null: false
    add_column :comment_votes, :comment_id, :integer, index: true, foreign_key: true, null: false
  end
end
