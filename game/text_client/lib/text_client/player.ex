defmodule TextClient.Player do
  
  alias TextClient.{State, Summary, Prompter, Mover}
  
  def play(%State{tally: %{ game_state: :won }}) do
    exit_with_message("VENCEU!")
    exit(:normal)
  end

  def play(%State{tally: %{ game_state: :lost }}) do
    exit_with_message("desculpa, você PERDEU!")
    exit(:normal)
  end

  def play(game = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "boa!")
  end

  def play(game = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "desculpa, não tá na palavra.")
  end

  def play(game = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "essa letra já foi usada.")
  end
  
  def play(game) do
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

end
