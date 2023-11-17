defmodule FutureLiveviewModalWeb.Modal do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true
  slot :inner_block, required: true

  def headless_modal(assigns) do
    ~H"""
    <dialog id={@id} phx-remove={hide(@id)}>
      <%= render_slot(@inner_block, hide(@id)) %>
    </dialog>
    """
  end

  def show(id) do
    JS.dispatch("show-dialog-modal", to: "##{id}")
  end

  def hide(id) do
    JS.dispatch("hide-dialog-modal", to: "##{id}")
  end
end
