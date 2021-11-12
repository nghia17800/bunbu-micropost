class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :post_id
<<<<<<< HEAD
      t.integer :parent_comment_id
=======
      t.integer :parent_id
>>>>>>> refs #3 Create table, validates, add associations.

      t.timestamps
    end
  end
end
