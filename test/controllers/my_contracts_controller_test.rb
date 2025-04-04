# test/controllers/users_controller_test.rb

require "test_helper"

class MyContractsControllerTest < ActionDispatch::IntegrationTest
  test "should get index and return json" do
    Spacinov::Container["db1.container"].relations.contracts.dataset.truncate(cascade: true)
    Spacinov::Container["db2.container"].relations.contracts.dataset.truncate(cascade: true)
    Spacinov::Container["db1.container"].relations.users.dataset.truncate(cascade: true)
    Spacinov::Container["db2.container"].relations.users.dataset.truncate(cascade: true)

    # db 1 contracts
    contract_a = Spacinov::Container["db1.container"].relations.contracts.command(:create).call(name: "Contract A", description: "", created_at: Time.now, updated_at: Time.now)
    contract_b = Spacinov::Container["db1.container"].relations.contracts.command(:create).call(name: "Contract B", description: "", created_at: Time.now, updated_at: Time.now)
    contract_c = Spacinov::Container["db1.container"].relations.contracts.command(:create).call(name: "Contract C", description: "", created_at: Time.now, updated_at: Time.now)
    # db 2 contracts
    contract_1 = Spacinov::Container["db2.container"].relations.contracts.command(:create).call(name: "Contract 1", description: "", created_at: Time.now, updated_at: Time.now)
    contract_2 = Spacinov::Container["db2.container"].relations.contracts.command(:create).call(name: "Contract 2", description: "", created_at: Time.now, updated_at: Time.now)

    # db 1 users
    alice = Spacinov::Container["db1.container"].relations.users.command(:create).call(name: "Alice", created_at: Time.now, updated_at: Time.now)
    bob = Spacinov::Container["db1.container"].relations.users.command(:create).call(name: "Bob", created_at: Time.now, updated_at: Time.now)
    # db 2 users
    tony = Spacinov::Container["db2.container"].relations.users.command(:create).call(name: "Tony", created_at: Time.now, updated_at: Time.now)

    Spacinov::Container["db1.container"].relations.users_contracts.command(:create).call(user_id: alice[:id], contract_id: contract_a[:id], created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db1.container"].relations.users_contracts.command(:create).call(user_id: alice[:id], contract_id: contract_b[:id], created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db1.container"].relations.users_contracts.command(:create).call(user_id: bob[:id], contract_id: contract_b[:id], created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db1.container"].relations.users_contracts.command(:create).call(user_id: bob[:id], contract_id: contract_c[:id], created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db2.container"].relations.users_contracts.command(:create).call(user_id: tony[:id], contract_id: contract_1[:id], created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db2.container"].relations.users_contracts.command(:create).call(user_id: tony[:id], contract_id: contract_2[:id], created_at: Time.now, updated_at: Time.now)

    get "/my_contracts?username=Alice", as: :json

    assert_response :success
    assert_equal "application/json", response.media_type

    body = JSON.parse(response.body)
    assert_equal 2, body.size

    contracts = body.map { |contract| [ contract["name"], contract["origin"] ] }
    assert_equal [
      [ "Contract A", "db1.container" ],
      [ "Contract B", "db1.container" ]
    ], contracts
  end
end
