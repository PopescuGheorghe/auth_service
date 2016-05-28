class CreateAuthKeys < ActiveRecord::Migration
  def change
    create_table :auth_keys do |t|
      t.string :token
      t.datetime :token_created_at

      t.timestamps null: false
    end
  end
end
