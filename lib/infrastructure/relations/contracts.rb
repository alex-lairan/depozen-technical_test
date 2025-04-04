module Infrastructure
  module Relations
    class Contracts < ROM::Relation[:sql]
      schema(:contracts, infer: false) do
      end
    end
  end
end
