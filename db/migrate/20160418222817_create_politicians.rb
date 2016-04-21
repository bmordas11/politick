class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :political_party, null: false
      t.text :stance, null: false, default: "(No stance added)"
      t.string :place_of_birth
      t.date :birthday

      t.timestamps null: false
    end
  end
end
