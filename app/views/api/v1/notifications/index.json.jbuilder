json.array! @notifications do |notification|
  json.extract! notification, :id, :date, :title, :description, :admin_id, :client_id, :seen
end
