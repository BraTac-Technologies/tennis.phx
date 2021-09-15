defmodule TennisPhx.PlayerUnitsTest do
  use TennisPhx.DataCase

  alias TennisPhx.PlayerUnits

  describe "player_units" do
    alias TennisPhx.PlayerUnits.Player_unit

    import TennisPhx.PlayerUnitsFixtures

    @invalid_attrs %{name: nil}

    test "list_player_units/0 returns all player_units" do
      player_unit = player_unit_fixture()
      assert PlayerUnits.list_player_units() == [player_unit]
    end

    test "get_player_unit!/1 returns the player_unit with given id" do
      player_unit = player_unit_fixture()
      assert PlayerUnits.get_player_unit!(player_unit.id) == player_unit
    end

    test "create_player_unit/1 with valid data creates a player_unit" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Player_unit{} = player_unit} = PlayerUnits.create_player_unit(valid_attrs)
      assert player_unit.name == "some name"
    end

    test "create_player_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PlayerUnits.create_player_unit(@invalid_attrs)
    end

    test "update_player_unit/2 with valid data updates the player_unit" do
      player_unit = player_unit_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Player_unit{} = player_unit} = PlayerUnits.update_player_unit(player_unit, update_attrs)
      assert player_unit.name == "some updated name"
    end

    test "update_player_unit/2 with invalid data returns error changeset" do
      player_unit = player_unit_fixture()
      assert {:error, %Ecto.Changeset{}} = PlayerUnits.update_player_unit(player_unit, @invalid_attrs)
      assert player_unit == PlayerUnits.get_player_unit!(player_unit.id)
    end

    test "delete_player_unit/1 deletes the player_unit" do
      player_unit = player_unit_fixture()
      assert {:ok, %Player_unit{}} = PlayerUnits.delete_player_unit(player_unit)
      assert_raise Ecto.NoResultsError, fn -> PlayerUnits.get_player_unit!(player_unit.id) end
    end

    test "change_player_unit/1 returns a player_unit changeset" do
      player_unit = player_unit_fixture()
      assert %Ecto.Changeset{} = PlayerUnits.change_player_unit(player_unit)
    end
  end
end
