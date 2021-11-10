class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
