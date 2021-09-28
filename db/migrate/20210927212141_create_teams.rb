class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :parent_proto_id

      t.string :proto_id, null: false
      t.datetime :effective_at, null: false
      t.boolean :active, default: true, null: false

      t.datetime :created_at
    end
  end
end
