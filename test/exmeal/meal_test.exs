defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Ecto.Changeset

  alias Exmeal.Meal
  # alias Exmeal.User

  # setup do
  #   user_params = build(:users_params)

  #   %User{"user_id" = user_id} = Exmeal.create_user(user_params)

  #   {:ok, user_id: user_id}
  # end

  # describe "changeset/1" do
  #   test "when all params are valid, returns a valid changeset" do
  #     user_params = build(:users_params)

  #     Exmeal.create_user(user_params)

  #     response =
  #       :meals_params
  #       |> build()
  #       |> Meal.changeset()

  #     assert %Changeset{
  #              changes: %{
  #                description: "Banana",
  #                date: ~D[2001-05-02],
  #                calories: 20,
  #                user_id: _user_id
  #              },
  #              valid?: true
  #            } = response
  #   end
  # end

  describe "changeset/1" do
    test "when all params are valid, returns a changeset for new meal entry" do
      params = build(:meals_params)

      response = Meal.changeset(params)

      assert %Changeset{changes: %{description: "Paçoca"}, valid?: true} = response
    end

    test "when there are invalid params, returns errors" do
      params = build(:meals_params, %{calories: 0, description: ""})

      response = Meal.changeset(params)

      expected_response = %{calories: ["must be greater than 0"], description: ["can't be blank"]}

      assert errors_on(response) == expected_response
    end
  end

  describe "changeset/2" do
    test "when all params are valid, returns a changeset for the updated meal entry" do
      params = build(:meals_params)
      params_update = %{calories: 20}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(params_update)

      assert %Changeset{changes: %{calories: 20}, valid?: true} = response
    end

    test "when there are invalid params, returns errors" do
      params = build(:meals_params)
      params_update = %{calories: 0}

      response =
        params
        |> Meal.changeset()
        |> Meal.changeset(params_update)

      expected_response = %{calories: ["must be greater than 0"]}

      assert errors_on(response) == expected_response
    end
  end
end
