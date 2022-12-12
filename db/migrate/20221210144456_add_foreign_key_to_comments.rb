class AddForeignKeyToComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.foreign_key :posts, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
      t.foreign_key :users, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
    end
  end
end
