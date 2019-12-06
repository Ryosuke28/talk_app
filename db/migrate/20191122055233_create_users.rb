class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :tel
      t.string :image
      t.boolean :admin

      t.timestamps
    end
  end
end
