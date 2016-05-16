json.array!(@dashboards) do |dashboard|
  json.extract! dashboard, :id, :calls, :clicks, :searches, :cost, :budget, :devise, :website_id
  json.url dashboard_url(dashboard, format: :json)
end
