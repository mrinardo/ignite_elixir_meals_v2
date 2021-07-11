defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Meal, User}

  describe "Create Meal" do
    test "when all params are valid, returns the meal" do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      {:ok, %Meal{id: id} = response} = Exmeal.create_meal(params)

      assert %Meal{
               calories: 20,
               date: ~U[2021-04-18 20:35:18.000000Z],
               description: "Paçoca",
               id: ^id,
               user_id: ^user_id
             } = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        calories: 20,
        date: ~U[2021-04-18 20:35:18.000000Z]
      }

      response = Exmeal.create_meal(params)

      assert {:error, %Exmeal.Error{}} = response
    end
  end
end
