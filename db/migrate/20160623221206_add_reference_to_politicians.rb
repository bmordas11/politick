class AddReferenceToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :actually_them, :integer
  end
end
