class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.string :person_proto_id, null: false
      t.string :team_proto_id, null: false
      t.string :role_on_team

      t.string :proto_id, null: false
      t.datetime :effective_at, null: false
      t.boolean :active, default: true, null: false

      t.datetime :created_at
    end
  end
end
