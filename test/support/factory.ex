defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.{Meal, User}

  def meals_params_factory do
    %{
      description: "Paçoca",
      date: ~U[2021-04-18 20:35:18.000000Z],
      calories: "20",
      user_id: "388fccf4-f3bb-4822-9817-973a62158d20"
    }
  end

  def meal_factory do
    %Meal{
      description: "Paçoca",
      date: ~U[2021-04-18 20:35:18.000000Z],
      calories: "20",
      user_id: "388fccf4-f3bb-4822-9817-973a62158d20",
      id: "69961117-d966-4e2f-ac55-476d4f78ddfa"
    }
  end

  def meal_api_params_factory do
    %{
      "description" => "Paçoca",
      "calories" => 20,
      "date" => "2021-04-18 20:35:18",
      "user_id" => "388fccf4-f3bb-4822-9817-973a62158d20"
    }
  end

  def users_params_factory do
    %{
      name: "Mauricio Rinardo",
      email: "mauricio@rinardo.com",
      cpf: "12345678901"
    }
  end

  def user_factory do
    %User{
      name: "Mauricio Rinardo",
      email: "mauricio@rinardo.com",
      cpf: "12345678901",
      id: "388fccf4-f3bb-4822-9817-973a62158d20"
    }
  end

  # def users_api_params_factory do
  #   %{
  #     "name" => "Mauricio Rinardo",
  #     "email" => "mauricio@rinardo.com",
  #     "cpf" => "12345678901"
  #   }
  # end
end
