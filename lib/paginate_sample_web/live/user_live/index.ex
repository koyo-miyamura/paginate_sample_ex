defmodule PaginateSampleWeb.UserLive.Index do
  use PaginateSampleWeb, :live_view

  alias PaginateSample.Users
  alias PaginateSample.Users.User

  @default_page 1
  @default_page_size 10

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Users.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
    |> assign(:users, list_users(params))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, assign(socket, :users, list_users())}
  end

  @impl true
  def handle_event("update_page", %{"page" => page}, socket) do
    params =
      socket.assigns
      |> Map.get(:users)
      |> Map.take([:page_number, :page_size])
      |> Map.merge(%{page_number: page})
      |> Keyword.new()

    {:noreply,
     push_redirect(socket,
       to: Routes.user_index_path(socket, :index, params)
     )}
  end

  @impl true
  def handle_event("update_page_size", %{"page_size" => page_size}, socket) do
    params =
      socket.assigns
      |> Map.get(:users)
      |> Map.take([:page_number, :page_size])
      |> Map.merge(%{page_size: page_size})
      |> Keyword.new()

    {:noreply,
     push_redirect(socket,
       to: Routes.user_index_path(socket, :index, params)
     )}
  end

  defp list_users() do
    Users.list_users()
  end

  defp list_users(%{"page_number" => page, "page_size" => page_size}) do
    Users.list_users(page, page_size)
  end

  defp list_users(%{"page_number" => page}) do
    Users.list_users(page, @default_page_size)
  end

  defp list_users(%{"page_size" => page_size}) do
    Users.list_users(@default_page, page_size)
  end

  defp list_users(%{}) do
    Users.list_users()
  end
end
