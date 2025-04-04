# test/controllers/users_controller_test.rb

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index and return json" do
    Spacinov::Container["db1.container"].relations.users.dataset.truncate(cascade: true)
    Spacinov::Container["db2.container"].relations.users.dataset.truncate(cascade: true)

    # db 1 users
    Spacinov::Container["db1.container"].relations.users.command(:create).call(name: "Alice", created_at: Time.now, updated_at: Time.now)
    Spacinov::Container["db1.container"].relations.users.command(:create).call(name: "Bob", created_at: Time.now, updated_at: Time.now)
    # db 2 users
    Spacinov::Container["db2.container"].relations.users.command(:create).call(name: "Tony", created_at: Time.now, updated_at: Time.now)

    get "/users", as: :json

    assert_response :success
    assert_equal "application/json", response.media_type

    body = JSON.parse(response.body)
    assert_equal 3, body.size

    users = body.map { |user| [ user["name"], user["origin"] ] }
    assert_equal [ [ "Alice", "db1.container" ], [ "Bob", "db1.container" ], [ "Tony", "db2.container" ] ], users
  end
end
