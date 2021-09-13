class CreatePersonSnapshots < ActiveRecord::Migration[6.1]
  def change
    create_table :person_snapshots do |t|
      t.string :proto_id
      t.datetime :effective_at
      t.string :first_name
      t.string :last_name
      t.string :title
      t.integer :manager_id

      t.timestamps
    end
  end
end
