class AddForeignKeyToPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.foreign_key :users, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
    end
  end
end
