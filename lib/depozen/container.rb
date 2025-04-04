module Depozen
  class Container < Dry::System::Container
    configure do |config|
      config.root = Pathname.new(__dir__).join("../..")
    end
  end
end
