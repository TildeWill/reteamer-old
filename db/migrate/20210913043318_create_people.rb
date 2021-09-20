class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :proto_id
      t.datetime :effective_at
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :supervisor_id
      t.string :email
      t.text :image_url
      t.boolean :terminated

      t.datetime :created_at
    end
  end
end
