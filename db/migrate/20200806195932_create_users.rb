class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.string :handle_name
      t.string :password_digest

      t.timestamps
    end
  end
end
