defmodule FutureLiveviewModalWeb.ModalLive.Index do
  use FutureLiveviewModalWeb, :live_view

  alias FutureLiveviewModalWeb.Modal
  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    socket
    |> assign(:page_title, "Modals")

    {:ok, socket}
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <div class="">
      <div class="h-screen grid place-items-center">
        <div class="bg-slate-200 p-8 rounded-lg grid gap-8">
          <h1 class="text-3xl">Modals</h1>

          <.button>See Modals</.button>
        </div>
      </div>

      <Modal.headless_modal />
    </div>
    """
  end

  @impl LiveView
  def handle_event("delete", %{"id" => id}, socket) do
    {:noreply, socket}
  end
end
