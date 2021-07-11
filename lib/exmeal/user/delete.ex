defmodule Exmeal.Users.Delete do
  alias Exmeal.{Error, Repo, User}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_delete(user)
    end
  end

  defp do_delete(user) do
    Repo.delete(user)
    |> handle_delete()
  end

  defp handle_delete({:ok, %User{}} = result), do: result

  defp handle_delete(result) do
    {:error, Error.build(:bad_request, result)}
  end
end
