class ContractsRepository < BaseRepository
  relations :contracts, :users

  def all
    for_all_containers do
      contracts
        .to_a
    end.flatten
  end

  def contracts_of_user(username)
    for_all_containers do
      contracts
        .join(:users)
        .select_append(users[:name].as(:username))
        .where(users[:name] => username)
        .to_a
    end.flatten
  end
end
