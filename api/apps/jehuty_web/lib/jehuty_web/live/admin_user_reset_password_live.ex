defmodule JehutyWeb.AdminUserResetPasswordLive do
  use JehutyWeb, :live_view

  alias Jehuty.Admin

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">Reset Password</.header>

      <.simple_form
        for={@form}
        id="reset_password_form"
        phx-submit="reset_password"
        phx-change="validate"
      >
        <.error :if={@form.errors != []}>
          Oops, something went wrong! Please check the errors below.
        </.error>

        <.input field={@form[:password]} type="password" label="New password" required />
        <.input
          field={@form[:password_confirmation]}
          type="password"
          label="Confirm new password"
          required
        />
        <:actions>
          <.button phx-disable-with="Resetting..." class="w-full">Reset Password</.button>
        </:actions>
      </.simple_form>

      <p class="text-center text-sm mt-4">
        <.link href={~p"/admin_user/register"}>Register</.link>
        | <.link href={~p"/admin_user/log_in"}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(params, _session, socket) do
    socket = assign_admin_user_and_token(socket, params)

    form_source =
      case socket.assigns do
        %{admin_user: admin_user} ->
          Admin.change_admin_user_password(admin_user)

        _ ->
          %{}
      end

    {:ok, assign_form(socket, form_source), temporary_assigns: [form: nil]}
  end

  # Do not log in the admin_user after reset password to avoid a
  # leaked token giving the admin_user access to the account.
  def handle_event("reset_password", %{"admin_user" => admin_user_params}, socket) do
    case Admin.reset_admin_user_password(socket.assigns.admin_user, admin_user_params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Password reset successfully.")
         |> redirect(to: ~p"/admin_user/log_in")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, Map.put(changeset, :action, :insert))}
    end
  end

  def handle_event("validate", %{"admin_user" => admin_user_params}, socket) do
    changeset = Admin.change_admin_user_password(socket.assigns.admin_user, admin_user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_admin_user_and_token(socket, %{"token" => token}) do
    if admin_user = Admin.get_admin_user_by_reset_password_token(token) do
      assign(socket, admin_user: admin_user, token: token)
    else
      socket
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: ~p"/")
    end
  end

  defp assign_form(socket, %{} = source) do
    assign(socket, :form, to_form(source, as: "admin_user"))
  end
end
