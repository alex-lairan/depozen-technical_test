class UsersRepository < BaseRepository
  include Dry::Effects.Resolve(:database)

  relations :users

  def all
    for_all_containers { |origin| users.to_a }.flatten
  end
end
