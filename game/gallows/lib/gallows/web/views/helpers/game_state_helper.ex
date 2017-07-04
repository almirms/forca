defmodule Gallows.Views.Helpers.GameStateHelper do
  
  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won              => { :success, "você venceu!" },
    :lost             => { :danger, "você PER-DEU! pode chutar acento e cê cedilhado, cabeÇÃO!" },     
    :good_guess       => { :success, "boa!!!" }, 
    :bad_guess        => { :warning, "não tem essa!" }, 
    :already_used     => { :info, "você já chutou essa!" } 
  }

  def game_state(state) do
    @responses[state]      
    |> alert()
  end

  defp alert(nil), do: ""
  defp alert({ class, message }) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end

end
