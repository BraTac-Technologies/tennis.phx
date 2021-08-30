defmodule TennisPhx.ParticipantsTest do
  use TennisPhx.DataCase

  alias TennisPhx.Participants

  describe "players" do
    alias TennisPhx.Participants.Player

    import TennisPhx.ParticipantsFixtures

    @invalid_attrs %{birthdate: nil, info: nil, name: nil, nickname: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Participants.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Participants.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{birthdate: ~N[2021-08-29 13:11:00], info: "some info", name: "some name", nickname: "some nickname"}

      assert {:ok, %Player{} = player} = Participants.create_player(valid_attrs)
      assert player.birthdate == ~N[2021-08-29 13:11:00]
      assert player.info == "some info"
      assert player.name == "some name"
      assert player.nickname == "some nickname"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Participants.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{birthdate: ~N[2021-08-30 13:11:00], info: "some updated info", name: "some updated name", nickname: "some updated nickname"}

      assert {:ok, %Player{} = player} = Participants.update_player(player, update_attrs)
      assert player.birthdate == ~N[2021-08-30 13:11:00]
      assert player.info == "some updated info"
      assert player.name == "some updated name"
      assert player.nickname == "some updated nickname"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Participants.update_player(player, @invalid_attrs)
      assert player == Participants.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Participants.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Participants.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Participants.change_player(player)
    end
  end
end
