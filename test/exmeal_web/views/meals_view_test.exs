defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  import Exmeal.Factory

  alias Exmeal.{Meal, User}

  alias ExmealWeb.MealsView

  setup do
    user_params = build(:users_params)

    {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

    {:ok, user_id: user_id}
  end

  test "render create.json", %{user_id: user_id} do
    params = build(:meal_api_params, %{"user_id" => user_id})
    {:ok, %Meal{id: id} = meal} = Exmeal.create_meal(params)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~U[2021-04-18 20:35:18.000000Z],
               description: "Paçoca",
               id: ^id,
               user_id: ^user_id
             },
             message: "Meal created!"
           } = response
  end

  test "render meal.json", %{user_id: user_id} do
    params = build(:meal_api_params, %{"user_id" => user_id})
    {:ok, %Meal{id: id} = meal} = Exmeal.create_meal(params)

    response = render(MealsView, "meal.json", meal: meal)

    assert %{
             meal: %Meal{
               calories: 20,
               date: ~U[2021-04-18 20:35:18.000000Z],
               description: "Paçoca",
               id: ^id,
               user_id: ^user_id
             }
           } = response
  end
end
