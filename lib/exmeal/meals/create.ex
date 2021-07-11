defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Meal, Repo, User}

  def call(%{"user_id" => user_id} = params) do
    case Repo.get(User, user_id) do
      nil -> {:error, Error.build_user_not_found_error()}
      _user -> do_insert(params)
    end
  end

  def call(_params) do
    {:error, Error.build(:bad_request, "Invalid parameter!")}
  end

  defp do_insert(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
