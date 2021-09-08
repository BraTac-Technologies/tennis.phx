defmodule TennisPhx.MatchesTest do
  use TennisPhx.DataCase

  alias TennisPhx.Matches

  describe "matches" do
    alias TennisPhx.Matches.Match

    import TennisPhx.MatchesFixtures

    @invalid_attrs %{location_id: nil, phase_id: nil, player1_id: nil, player2_id: nil, player_unit_id: nil, score: nil, starting_datetime: nil, status_id: nil, tour_id: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Matches.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Matches.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{location_id: "some location_id", phase_id: "some phase_id", player1_id: "some player1_id", player2_id: "some player2_id", player_unit_id: "some player_unit_id", score: %{}, starting_datetime: ~N[2021-09-07 09:39:00], status_id: "some status_id", tour_id: "some tour_id"}

      assert {:ok, %Match{} = match} = Matches.create_match(valid_attrs)
      assert match.location_id == "some location_id"
      assert match.phase_id == "some phase_id"
      assert match.player1_id == "some player1_id"
      assert match.player2_id == "some player2_id"
      assert match.player_unit_id == "some player_unit_id"
      assert match.score == %{}
      assert match.starting_datetime == ~N[2021-09-07 09:39:00]
      assert match.status_id == "some status_id"
      assert match.tour_id == "some tour_id"
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Matches.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{location_id: "some updated location_id", phase_id: "some updated phase_id", player1_id: "some updated player1_id", player2_id: "some updated player2_id", player_unit_id: "some updated player_unit_id", score: %{}, starting_datetime: ~N[2021-09-08 09:39:00], status_id: "some updated status_id", tour_id: "some updated tour_id"}

      assert {:ok, %Match{} = match} = Matches.update_match(match, update_attrs)
      assert match.location_id == "some updated location_id"
      assert match.phase_id == "some updated phase_id"
      assert match.player1_id == "some updated player1_id"
      assert match.player2_id == "some updated player2_id"
      assert match.player_unit_id == "some updated player_unit_id"
      assert match.score == %{}
      assert match.starting_datetime == ~N[2021-09-08 09:39:00]
      assert match.status_id == "some updated status_id"
      assert match.tour_id == "some updated tour_id"
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Matches.update_match(match, @invalid_attrs)
      assert match == Matches.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Matches.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Matches.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Matches.change_match(match)
    end
  end
end
