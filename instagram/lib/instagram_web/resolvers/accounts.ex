defmodule InstagramWeb.Resolvers.Accounts do
  alias InstagramWeb.Authentication

  def login(_, %{provider: provider, token: token}, _) do
    case provider do
      :facebook ->
        {:ok, user} = Authentication.login(token, "facebook")

        {:ok, token, _} = InstagramWeb.Auth.Guardian.encode_and_sign(user)

        {:ok, %{token: token}}
    end
  end
end
