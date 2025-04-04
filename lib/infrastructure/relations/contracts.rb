module Infrastructure
  module Relations
    class Contracts < ROM::Relation[:sql]
      schema(:contracts, infer: true) do
        associations do
          has_many :users_contracts
          has_many :users, through: :users_contracts
        end
      end
    end
  end
end
