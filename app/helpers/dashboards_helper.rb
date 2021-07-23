module DashboardsHelper

def pluck_pivot_table(dashboard)
  pluckIds = []
  dashboard.save_pivot_tables.each do|pivot|
    pluckIds.push(pivot.id)
  end
  return pluckIds
end

end
