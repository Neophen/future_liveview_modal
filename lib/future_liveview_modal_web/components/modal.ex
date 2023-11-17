defmodule FutureLiveviewModalWeb.Modal do
  use Phoenix.Component

  def headless_modal(assigns) do
    ~H"""
    <div class="">
      Hello World!
    </div>
    """
  end
end
