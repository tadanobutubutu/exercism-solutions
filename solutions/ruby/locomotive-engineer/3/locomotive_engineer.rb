class LocomotiveEngineer
  def self.generate_list_of_wagons(*args)
    args
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    a, b, c, *rest = each_wagons_id
    [c, *missing_wagons, *rest, a, b]
  end

  def self.add_missing_stops(route, **kwargs)
    route.merge(stops: kwargs.values)
  end

  def self.extend_route_information(route, more_route_information)
    route.merge(more_route_information)
  end
end
