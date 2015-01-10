class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :altbtcaddy
      t.text :message

      t.timestamps null: false
    end
  end
end
