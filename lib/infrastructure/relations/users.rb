module Infrastructure
  module Relations
    class Users < ROM::Relation[:sql]
      schema(:users, infer: true) do
      end
    end
  end
end
