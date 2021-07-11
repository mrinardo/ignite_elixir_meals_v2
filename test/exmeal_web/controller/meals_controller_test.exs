defmodule Exmeal.MealsControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.{Meal, User}

  describe "create/2" do
    test "when all params are valid, creates a meal", %{conn: conn} do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:created)

      %{"meal" => %{"id" => id}} = response

      assert %{
               "meal" => %{
                 "calories" => 20,
                 "date" => "2021-04-18T20:35:18.000000Z",
                 "description" => "Paçoca",
                 "id" => ^id,
                 "user_id" => ^user_id
               },
               "message" => "Meal created!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = %{description: "Paçoca", user_id: user_id}

      expected_response = %{
        "message" => %{
          "calories" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.meals_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the meal", %{conn: conn} do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      {:ok, %Meal{id: id}} = Exmeal.create_meal(params)

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> response(:no_content)

      assert "" = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> delete(Routes.meals_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{
               "message" => "Meal not found!"
             } = response
    end
  end

  describe "update/2" do
    test "when id exist, update the meal", %{conn: conn} do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      {:ok, %Meal{id: id}} = Exmeal.create_meal(params)

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 20,
                 "date" => "2021-04-18T20:35:18.000000Z",
                 "description" => "Paçoca",
                 "id" => ^id,
                 "user_id" => ^user_id
               }
             } = response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> put(Routes.meals_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found!"} = response
    end
  end

  describe "get/2" do
    test "when id exist, return the meal", %{conn: conn} do
      user_params = build(:users_params)

      {:ok, %User{id: user_id}} = Exmeal.create_user(user_params)

      params = build(:meal_api_params, %{"user_id" => user_id})

      {:ok, %Meal{id: id}} = Exmeal.create_meal(params)

      response =
        conn
        |> get(Routes.meals_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => 20,
                 "date" => "2021-04-18T20:35:18.000000Z",
                 "description" => "Paçoca",
                 "id" => ^id,
                 "user_id" => ^user_id
               }
             } = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> get(Routes.meals_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found!"} = response
    end
  end
end
