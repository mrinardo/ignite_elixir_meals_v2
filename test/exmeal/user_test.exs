defmodule Exmeal.UserTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Ecto.Changeset

  alias Exmeal.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:users_params)

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 cpf: "12345678901",
                 name: "Mauricio Rinardo",
                 email: "mauricio@rinardo.com"
               },
               valid?: true
             } = response
    end

    test "when there are invalid params, returns errors" do
      params = build(:users_params, %{cpf: "123", email: "mauricio.rinardo.com"})

      response = User.changeset(params)

      expected_response = %{cpf: ["should be 11 character(s)"], email: ["has invalid format"]}

      assert errors_on(response) == expected_response
    end
  end
end
