class InitialTables < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest

      t.timestamps
    end

    create_table :recipes do |t|
      t.string :name
      t.integer :user_id
      t.boolean :private, default: false
      t.string :instructions

      t.timestamps
    end
  end
end
