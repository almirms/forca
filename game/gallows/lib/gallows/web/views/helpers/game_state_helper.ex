defmodule Gallows.Views.Helpers.GameStateHelper do
  
  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won              => { :success, "você venceu!" },
    :lost             => { :danger, "você PER-DEU!" },
    :good_guess       => { :success, "boa!!!" },
    :bad_guess        => { :warning, "não tem essa!" },
    :invalid_guess    => { :warning, "só uma letra minúscula, pfv (acento vale, cabeÇÃO!)!" },
    :already_used     => { :info, "você já chutou essa!" }
  }

  def game_state(state) do
    @responses[state]      
    |> alert()
  end

  defp alert(nil), do: ""
  defp alert({ class, message }) do
    """
    <div class="alert alert-#{class}" style="text-align:center;">
      #{message}
    </div>
    """
    |> raw()
  end

end
