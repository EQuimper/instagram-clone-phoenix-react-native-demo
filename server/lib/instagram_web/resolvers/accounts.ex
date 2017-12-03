defmodule InstagramWeb.Resolvers.Accounts do
  alias InstagramWeb.Authentication
  alias Instagram.Accounts

  def login(_, %{provider: provider, token: token}, _) do
    case provider do
      :facebook ->
        {:ok, user} = Authentication.login(token, "facebook")

        {:ok, token, _} = InstagramWeb.Auth.Guardian.encode_and_sign(user)

        {:ok, %{token: token}}
    end
  end

  def update_user(_, args, %{context: %{current_user: current_user}}) do
    with {:ok, user} <- Accounts.update_user(current_user, args) do
      {:ok, user}
    else
      {:error, changeset} ->
        [%Kronky.ValidationMessage{} = error] = Kronky.ChangesetParser.extract_messages(changeset)
        {:error, "#{error.key} #{error.message}"}
    end
  end
end
