json.extract! person_snapshot, :id, :meta_id, :effective_at, :first_name, :last_name, :title, :manager_id, :created_at, :updated_at
json.url person_snapshot_url(person_snapshot, format: :json)
