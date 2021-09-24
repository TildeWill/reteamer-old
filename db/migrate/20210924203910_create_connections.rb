class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.string :proto_id, null: false
      t.string :person_proto_id, null: false
      t.string :other_supervisor_proto_id, null: false
      t.string :label
      t.datetime :effective_at, null: false
      t.boolean :active, default: true, null: false

      t.datetime :created_at
    end
  end
end
