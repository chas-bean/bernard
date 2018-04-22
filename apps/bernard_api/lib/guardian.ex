defmodule BernardApi.Guardian do
  use Guardian, otp_app: :bernard_api
    # secret_key: "zlMmcWhu85hfZNxIOZ0ybhoovSNNeDTqmzhRaFSxEzlBfUEncqK8K9iNYegHD"
    # secret_key: System.get_env("API_JWT_SECRET_KEY")
    # secret_key: {BernardApi.Config, :get_environment_variable, ["API_JWT_SECRET_KEY"]}

  alias BernardCore.Accounts
  alias BernardCore.Accounts.User

  def subject_for_token(%User{:id => id} = _user, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    user = claims["sub"] |> Accounts.get_user!
    {:ok,  user}
  end
end