defmodule Exmeal.UsersControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.User

  describe "create/2" do
    test "when all params are valid, creates a user", %{conn: conn} do
      params = build(:users_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      %{"user" => %{"id" => id}} = response

      assert %{
               "user" => %{
                 "cpf" => "12345678901",
                 "email" => "mauricio@rinardo.com",
                 "id" => ^id,
                 "name" => "Mauricio Rinardo"
               },
               "message" => "User created!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{description: "Banana"}

      expected_response = %{
        "message" => %{
          "cpf" => ["can't be blank"],
          "name" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when id exist, delete the user", %{conn: conn} do
      params = build(:users_params)

      {:ok, %User{id: id}} = Exmeal.create_user(params)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert "" = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{
               "message" => "User not found!"
             } = response
    end
  end

  describe "update/2" do
    test "when id exist, update the user", %{conn: conn} do
      params = build(:users_params)

      {:ok, %User{id: id}} = Exmeal.create_user(params)

      updated_params = %{
        name: "J. M. Rinardo"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, updated_params))
        |> json_response(:ok)

      %{"user" => %{"id" => id}} = response

      assert %{
               "user" => %{
                 "cpf" => "12345678901",
                 "email" => "mauricio@rinardo.com",
                 "name" => "J. M. Rinardo",
                 "id" => ^id
               }
             } = response
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> put(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end

  describe "get/2" do
    test "when id exist, return the meal", %{conn: conn} do
      params = build(:users_params)

      {:ok, %User{id: id}} = Exmeal.create_user(params)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      %{"user" => %{"id" => id}} = response

      assert %{
               "user" => %{
                 "cpf" => "12345678901",
                 "email" => "mauricio@rinardo.com",
                 "name" => "Mauricio Rinardo",
                 "id" => ^id
               }
             } = response
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = "00000000-0000-0000-0000-000000000000"

      response =
        conn
        |> get(Routes.users_path(conn, :update, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found!"} = response
    end
  end
end
