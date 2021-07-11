defmodule Exmeal.User.UpdateTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.User

  describe "Update Meal" do
    test "when a valid id is given, returns the meal" do
      user_params = build(:users_params)

      {:ok, %User{id: id}} = Exmeal.create_user(user_params)

      response = Exmeal.update_user(%{"id" => id, "name" => "J. M. Rinardo"})

      assert {:ok,
              %User{
                name: "J. M. Rinardo",
                email: "mauricio@rinardo.com",
                cpf: "12345678901",
                id: ^id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"
      response = Exmeal.update_user(%{"id" => id})

      expected_response = Exmeal.Error.build_user_not_found_error()

      assert {:error, expected_response} == response
    end
  end
end
