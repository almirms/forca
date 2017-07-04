defmodule TextClient.Summary do
  def display(game = %{ tally: tally}) do
    IO.puts [
      "\n", 
      "palavra:    #{Enum.join(tally.letters, " ")}",
      "\n", 
      "chances restantes:   #{tally.turns_left}",
      "\n",
      "letras já chutadas: #{tally.letters_used}",
      "\n"
    ]
    game  
  end
end
