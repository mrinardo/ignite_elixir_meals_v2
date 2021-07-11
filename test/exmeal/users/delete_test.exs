defmodule Exmeal.Users.DeleteTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.User

  describe "Delete user" do
    test "when a valid id is given, returns the user" do
      params = build(:users_params)

      {:ok, %User{id: id}} = Exmeal.create_user(params)

      response = Exmeal.delete_user(id)

      assert {:ok,
              %User{
                name: "Mauricio Rinardo",
                email: "mauricio@rinardo.com",
                cpf: "12345678901",
                id: ^id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"
      response = Exmeal.delete_user(id)

      expected_response = Exmeal.Error.build_user_not_found_error()

      assert {:error, expected_response} == response
    end
  end
end
