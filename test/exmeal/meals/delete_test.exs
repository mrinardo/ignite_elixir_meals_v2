defmodule Exmeal.Meals.DeleteTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.{Meal, User}

  describe "Delete Meal" do
    test "when a valid id is given, returns the meal" do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      {:ok, %Meal{id: id}} = Exmeal.create_meal(params)

      response = Exmeal.delete_meal(id)

      assert {:ok, %Meal{}} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "00000000-0000-0000-0000-000000000000"
      response = Exmeal.delete_meal(id)

      assert {:error, %Exmeal.Error{status: :not_found, result: _result}} = response
    end
  end
end
