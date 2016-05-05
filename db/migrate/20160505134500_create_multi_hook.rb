class CreateMultiHook < ActiveRecord::Migration
  def change
    create_table :hooks do |t|
      t.string :token, null: false
      t.string :type, null: false
      t.json :config, null: false, default: {}
      t.timestamps null: false
    end
    add_index :hooks, :token, unique: true
  end
end
