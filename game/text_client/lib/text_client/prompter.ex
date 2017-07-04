defmodule TextClient.Prompter do
  
  alias TextClient.State
  
  def accept_move(game = %State{}) do
    IO.gets("chuta uma letra: ")
    |> check_input(game)
  end

  defp check_input({ :error, reason }, _) do
    IO.puts("fim de jogo: #{reason}")
    exit(:normal)
  end

  defp check_input(:eof, _) do
    IO.puts("parece que você desistiu...")
    exit(:normal)
  end

  defp check_input(input, game = %State{}) do
    input = String.trim(input)
    cond do
      input =~ ~r/[a-záàâãéêíóôõöúç]/ ->
        Map.put(game, :guess, input)    
      true -> 
        IO.puts("pfv uma única letra minúscula")
        accept_move(game)
    end
  end

end
