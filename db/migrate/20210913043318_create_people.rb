class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :proto_id, null: false
      t.datetime :effective_at, null: false
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :employee_id
      t.string :supervisor_proto_id
      t.string :email
      t.text :image_url
      t.boolean :active, default: true, null: false
      t.boolean :contractor, default: false, null: false

      t.datetime :created_at
    end
  end
end
