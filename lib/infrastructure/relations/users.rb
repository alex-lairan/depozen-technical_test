module Infrastructure
  module Relations
    class Users < ROM::Relation[:sql]
      schema(:users, infer: true) do
        associations do
          has_many :users_contracts
          has_many :contracts, through: :users_contracts
        end
      end
    end
  end
end
