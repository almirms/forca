defmodule Gallows.Web.HangmanView do
  use Gallows.Web, :view

  import Gallows.Views.Helpers.GameStateHelper

  def turn(left, target) when target >= left do
    "opacity: 1"  
  end

  def turn(_left, _target) do
    "opacity: 0.1"  
  end

  def game_over?(%{ game_state: game_state }) do
    game_state in [ :won, :lost ]
  end

  def game_initializing?(%{ game_state: game_state }) do
    game_state == :initializing
  end
  
  def new_game_button(conn) do
    button("novo jogo", to: hangman_path(conn, :create_game), id: "novo_jogo")
  end

end
