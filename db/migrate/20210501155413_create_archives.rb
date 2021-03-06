class CreateArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :archives do |t|
      t.string :name, null: false, default: ""
      t.string :token, null: false, default: ""

      t.timestamps
    end

    add_index :archives, :token, unique: true

  end
end
