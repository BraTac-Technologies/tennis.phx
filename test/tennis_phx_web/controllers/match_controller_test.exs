defmodule TennisPhxWeb.MatchControllerTest do
  use TennisPhxWeb.ConnCase

  import TennisPhx.MatchesFixtures

  @create_attrs %{location_id: "some location_id", phase_id: "some phase_id", player1_id: "some player1_id", player2_id: "some player2_id", player_unit_id: "some player_unit_id", score: %{}, starting_datetime: ~N[2021-09-07 09:39:00], status_id: "some status_id", tour_id: "some tour_id"}
  @update_attrs %{location_id: "some updated location_id", phase_id: "some updated phase_id", player1_id: "some updated player1_id", player2_id: "some updated player2_id", player_unit_id: "some updated player_unit_id", score: %{}, starting_datetime: ~N[2021-09-08 09:39:00], status_id: "some updated status_id", tour_id: "some updated tour_id"}
  @invalid_attrs %{location_id: nil, phase_id: nil, player1_id: nil, player2_id: nil, player_unit_id: nil, score: nil, starting_datetime: nil, status_id: nil, tour_id: nil}

  describe "index" do
    test "lists all matches", %{conn: conn} do
      conn = get(conn, Routes.match_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Matches"
    end
  end

  describe "new match" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.match_path(conn, :new))
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "create match" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.match_path(conn, :create), match: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.match_path(conn, :show, id)

      conn = get(conn, Routes.match_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Match"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.match_path(conn, :create), match: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "edit match" do
    setup [:create_match]

    test "renders form for editing chosen match", %{conn: conn, match: match} do
      conn = get(conn, Routes.match_path(conn, :edit, match))
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "update match" do
    setup [:create_match]

    test "redirects when data is valid", %{conn: conn, match: match} do
      conn = put(conn, Routes.match_path(conn, :update, match), match: @update_attrs)
      assert redirected_to(conn) == Routes.match_path(conn, :show, match)

      conn = get(conn, Routes.match_path(conn, :show, match))
      assert html_response(conn, 200) =~ "some updated location_id"
    end

    test "renders errors when data is invalid", %{conn: conn, match: match} do
      conn = put(conn, Routes.match_path(conn, :update, match), match: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "delete match" do
    setup [:create_match]

    test "deletes chosen match", %{conn: conn, match: match} do
      conn = delete(conn, Routes.match_path(conn, :delete, match))
      assert redirected_to(conn) == Routes.match_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.match_path(conn, :show, match))
      end
    end
  end

  defp create_match(_) do
    match = match_fixture()
    %{match: match}
  end
end
