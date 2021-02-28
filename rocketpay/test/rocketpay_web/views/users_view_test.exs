defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "User",
      password: "123456",
      nickname: "user",
      email: "user@test.com",
      age: 21
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User Created",
      user: %{
        account: %{
          balance: Decimal.new("0.0"),
          id: account_id
        },
        id: user_id,
        name: "User",
        nickname: "user"
      }
    }

    assert expected_response == response
  end
end
