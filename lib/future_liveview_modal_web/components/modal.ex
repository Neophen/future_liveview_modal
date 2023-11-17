defmodule FutureLiveviewModalWeb.Modal do
  use Phoenix.Component

  def headless_modal(assigns) do
    ~H"""
    <dialog id="some-modal" >
        <h1>Hello World!</h1>
    </dialog>
    """
  end
end
