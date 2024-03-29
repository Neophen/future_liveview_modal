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
    <div>
      <div class="h-screen grid place-items-center">
        <div class="bg-slate-200 p-8 rounded-lg grid gap-8">
          <h1 class="text-3xl">Modals</h1>

          <.button phx-click={Modal.show("modal")}>See Modal</.button>
          <Modal.modal
            :let={%{close: close, cancel: cancel}}
            id="modal"
            on_cancel={JS.dispatch("test-on-cancel")}
          >
            <div class="space-y-4">
              <h1>Hello World!</h1>
              <.button phx-click={cancel}>Cancel</.button>
              <.button phx-click={close}>Close</.button>
            </div>
          </Modal.modal>
        </div>
      </div>
    </div>
    """
  end
end
