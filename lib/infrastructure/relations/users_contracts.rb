module Infrastructure
  module Relations
    class UsersContracts < ROM::Relation[:sql]
      schema(:users_contracts, infer: true) do
        associations do
          belongs_to :users
          belongs_to :contracts
        end
      end
    end
  end
end
