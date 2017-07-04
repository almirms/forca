defmodule GameTest do
  use ExUnit.Case

    alias Hangman.Game

    test "new_game returns structure" do
      game = Game.new_game()

      assert game.turns_left == 7
      assert game.game_state == :initializing
      assert length(game.letters) > 0
      assert String.match?(List.to_string(game.letters), ~r/[a-zç]/)
    end

    test "state isn't changed for :won or :lost game" do
      for state <- [ :won, :lost ] do
        game = Game.new_game() |> Map.put(:game_state, state)
        assert { ^game, _tally } = Game.make_move(game, "x")
      end
    end

    test "first occurrence of letter is not already used" do
      game = Game.new_game()
      { game, _tally }  = Game.make_move(game, "x")
      assert game.game_state != :already_used
    end

    test "second occurrence of letter is already used" do
      game = Game.new_game()
      { game, _tally }  = Game.make_move(game, "x")
      assert game.game_state != :already_used
      { game, _tally }  = Game.make_move(game, "x")
      assert game.game_state == :already_used
    end

    test "a good guess is recognized" do
      game = Game.new_game("caqui")
      { game, _tally } = Game.make_move(game, "c")
      assert game.game_state == :good_guess
    end

    test "a guessed word in a won game" do
      moves = [
        {"c", :good_guess}, 
        {"a", :good_guess}, 
        {"q", :good_guess}, 
        {"u", :good_guess}, 
        {"i", :won}
      ]

      game = Game.new_game("caqui")
      
      Enum.reduce(moves, game, fn ({ guess, state }, new_game) ->
        { new_game, _tally } = Game.make_move(new_game, guess)
        assert new_game.game_state == state
        new_game
      end)  
    end

    test "bad guess is recognized" do
      game = Game.new_game("caqui")
      { game, _tally } = Game.make_move(game, "x")
      assert game.game_state == :bad_guess
      assert game.turns_left == 6
    end

    test "lost game is recognized" do
      moves = [
        {"x", :bad_guess, 6}, 
        {"z", :bad_guess, 5}, 
        {"ç", :bad_guess, 4}, 
        {"ã", :bad_guess, 3},
        {"é", :bad_guess, 2},
        {"p", :bad_guess, 1},
        {"w", :lost,      0}
      ]
      
      game = Game.new_game("caqui")
      
      Enum.reduce(moves, game, fn ({ guess, state, turns_left }, new_game) ->
        { new_game, _tally } = Game.make_move(new_game, guess)
        assert new_game.game_state == state
        assert new_game.turns_left == turns_left
        new_game
      end)
    end

end
