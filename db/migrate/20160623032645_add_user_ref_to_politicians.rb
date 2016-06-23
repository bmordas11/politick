class AddUserRefToPoliticians < ActiveRecord::Migration
  def change
    add_reference :politicians, :user, index: true, foreign_key: true
  end
end
