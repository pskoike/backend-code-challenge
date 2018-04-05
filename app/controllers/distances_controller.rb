class DistancesController < ApplicationController
  def create
    pattern = /[A-Z]\s[A-Z]\s\d{1,6}/
    render json: {
      status: 'ERROR',
      message: 'distance not saved'
    }, status: :unprocessable_entity and return if pattern.match(params[:distance]).nil?

    params = distance_params['distance'].split
    params = { origin: params.first,
               destination: params.second,
               km: params.last }
    distance = Distance.where('origin = ? AND destination = ?', params[:origin], params[:destination]).first_or_initialize(params).update(params)
    if distance
      render json: {
        status: 'SUCCESS',
        message: 'distance saved'
      }, status: :ok
    else
      render json: {
        status: 'ERROR',
        message: 'distance not saved'
      }, status: :unprocessable_entity
    end
  end

  def cost
    origin = params[:origin].upcase
    destination = params[:destination].upcase
    weight = params[:weight].to_i

    direct_distance = Distance.where('origin = ? AND destination = ?', origin, destination).first

    if validate_route(direct_distance)
      render(json: { status: 'ERROR', message: "No route from #{params[:origin]} to #{params[:destination]}" }, status: 422) && return
    end

    if validate_weight(weight)
      render(json: { status: 'ERROR', message: 'Weight must be between 0 and 50' }, status: 422) && return
    end

    shortest_distance = calc_short_distance(origin, destination)
    shortest_distance = direct_distance if direct_distance.km < shortest_distance

    cost = shortest_distance * weight * 0.15

    render json: { status: 'SUCCESS', cost: cost, result: shortest_distance }, status: :ok
  end

  private

  def validate_route(route)
    route.nil?
  end

  def validate_weight(weight)
    (0..50).exclude?(weight)
  end

  def calc_short_distance(origin, destination)
    list = []
    Distance.all.each do |node|
      list << Bio::Relation.new(node.origin, node.destination, node.km)
    end
    list = Bio::Pathway.new(list, 'undirected')
    distance = list.dijkstra(origin)[0][destination]
  end

  def distance_params
    params.permit(:distance)
  end
end
