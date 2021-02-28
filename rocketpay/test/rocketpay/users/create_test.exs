defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an error" do
      params = %{
        name: "User",
        password: "123456",
        nickname: "user",
        email: "user@test.com",
        age: 21
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "User", age: 21, id: ^user_id} = user
    end
    test "when there are invalid params, returns an user" do
      params = %{
        name: "User",
        password: "12345",
        nickname: "user",
        email: "user@test.com",
        age: 17
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"], password: ["should be at least 6 character(s)"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
