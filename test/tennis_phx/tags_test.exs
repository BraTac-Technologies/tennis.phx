defmodule TennisPhx.TagsTest do
  use TennisPhx.DataCase

  alias TennisPhx.Tags

  describe "tags" do
    alias TennisPhx.Tags.Tag

    import TennisPhx.TagsFixtures

    @invalid_attrs %{name: nil, player_id: nil, points: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Tags.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Tags.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{name: "some name", player_id: "some player_id", points: 42}

      assert {:ok, %Tag{} = tag} = Tags.create_tag(valid_attrs)
      assert tag.name == "some name"
      assert tag.player_id == "some player_id"
      assert tag.points == 42
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{name: "some updated name", player_id: "some updated player_id", points: 43}

      assert {:ok, %Tag{} = tag} = Tags.update_tag(tag, update_attrs)
      assert tag.name == "some updated name"
      assert tag.player_id == "some updated player_id"
      assert tag.points == 43
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_tag(tag, @invalid_attrs)
      assert tag == Tags.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Tags.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_tag(tag)
    end
  end
end
