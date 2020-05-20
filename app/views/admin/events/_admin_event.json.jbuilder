json.extract! admin_event, :id, :name, :start_datetime, :end_datetime, :address, :description, :link, :created_at, :updated_at
json.url admin_event_url(admin_event, format: :json)
