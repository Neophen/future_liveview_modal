defmodule FutureLiveviewModalWeb.Modal do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :class, :any, default: nil
  attr :on_cancel, JS, default: %JS{}
  slot :inner_block, required: true

  def headless_modal(assigns) do
    ~H"""
    <dialog
      id={@id}
      phx-mounted={@show && show(@id)}
      phx-remove={close(@id)}
      data-cancel={JS.exec(@on_cancel, "phx-remove")}
      phx-window-keydown={cancel(@id)}
      phx-key="escape"
      class={@class}
    >
      <%!-- We pass in both the options for our component consumers --%>
      <%= render_slot(@inner_block, %{close: close(@id), cancel: cancel(@id)}) %>
    </dialog>
    """
  end

  def show(id) do
    JS.dispatch("show-dialog-modal", to: "##{id}")
  end

  def close(id) do
    JS.dispatch("hide-dialog-modal", to: "##{id}")
  end

  def cancel(id) do
    JS.exec("data-cancel", to: "##{id}")
  end
end
