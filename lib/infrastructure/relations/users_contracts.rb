module Infrastructure
  module Relations
    class UsersContracts < ROM::Relation[:sql]
      schema(:users_contracts, infer: false) do
      end
    end
  end
end
