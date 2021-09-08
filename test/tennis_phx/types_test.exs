defmodule TennisPhx.TypesTest do
  use TennisPhx.DataCase

  alias TennisPhx.Types

  describe "types" do
    alias TennisPhx.Types.Type

    import TennisPhx.TypesFixtures

    @invalid_attrs %{name: nil}

    test "list_types/0 returns all types" do
      type = type_fixture()
      assert Types.list_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert Types.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Type{} = type} = Types.create_type(valid_attrs)
      assert type.name == "some name"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Types.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Type{} = type} = Types.update_type(type, update_attrs)
      assert type.name == "some updated name"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = Types.update_type(type, @invalid_attrs)
      assert type == Types.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = Types.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> Types.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = Types.change_type(type)
    end
  end
end
