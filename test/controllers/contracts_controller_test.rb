# test/controllers/users_controller_test.rb

require "test_helper"

class ContractsControllerTest < ActionDispatch::IntegrationTest
  test "should get index and return json" do
    Depozen::Container["db1.container"].relations.contracts.dataset.truncate(cascade: true)
    Depozen::Container["db2.container"].relations.contracts.dataset.truncate(cascade: true)

    # db 1 contracts
    Depozen::Container["db1.container"].relations.contracts.command(:create).call(name: "Contract A", description: "", created_at: Time.now, updated_at: Time.now)
    Depozen::Container["db1.container"].relations.contracts.command(:create).call(name: "Contract B", description: "", created_at: Time.now, updated_at: Time.now)
    # db 2 contracts
    Depozen::Container["db2.container"].relations.contracts.command(:create).call(name: "Contract 1", description: "", created_at: Time.now, updated_at: Time.now)
    Depozen::Container["db2.container"].relations.contracts.command(:create).call(name: "Contract 2", description: "", created_at: Time.now, updated_at: Time.now)
    Depozen::Container["db2.container"].relations.contracts.command(:create).call(name: "Contract 3", description: "", created_at: Time.now, updated_at: Time.now)

    get "/contracts", as: :json

    assert_response :success
    assert_equal "application/json", response.media_type

    body = JSON.parse(response.body)
    assert_equal 5, body.size

    contracts = body.map { |contract| [ contract["name"], contract["origin"] ] }
    assert_equal [
      [ "Contract A", "db1.container" ],
      [ "Contract B", "db1.container" ],
      [ "Contract 1", "db2.container" ],
      [ "Contract 2", "db2.container" ],
      [ "Contract 3", "db2.container" ]
    ], contracts
  end
end
