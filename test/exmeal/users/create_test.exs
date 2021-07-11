defmodule Exmeal.Users.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.User

  describe "Create User" do
    test "when all params are valid, returns the user" do
      user_params = build(:users_params)

      {:ok, response} = Exmeal.create_user(user_params)

      id = response.id

      assert %User{
               name: "Mauricio Rinardo",
               email: "mauricio@rinardo.com",
               cpf: "12345678901",
               id: ^id
             } = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        cpf: 12_345_678_900,
        email: "mauricio.rinardo.com"
      }

      response = Exmeal.create_user(params)

      assert {:error, %Exmeal.Error{}} = response
    end
  end
end
