json.array!(@data_dashboards) do |data_dashboard|
  json.extract! data_dashboard, :id, :calls, :clicks, :searches, :cost, :budget, :smartphones, :tablets, :computers, :dashboard_id
  json.url data_dashboard_url(data_dashboard, format: :json)
end
