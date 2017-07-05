defmodule Gallows.Web.HangmanController do
  use Gallows.Web, :controller

  require Logger

  def create_game(conn, _params) do
    conn
    |> log_requests

    game = Hangman.new_game()
    tally = Hangman.tally(game)
    conn 
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def make_move(conn, params) do
    conn
    |> log_requests

    guess = params["make_move"]["guess"] |> String.downcase()
    tally = 
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)
    put_in(conn.params["make_move"]["guess"], "")
    |> render("game_field.html", tally: tally)
  end

  defp log_requests(conn) do
    Logger.info(
          Enum.join([
            "type: " <> "request",
            "remoteip: " <> Enum.join(Tuple.to_list(conn.remote_ip), ","),
            "method: " <> conn.method,
            "path: " <> conn.request_path,
            "size_res: " <> to_string(byte_size(to_string(conn.resp_body))),
          ], ", ")
        )
  end

end
