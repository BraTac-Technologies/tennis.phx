defmodule TennisPhx.EventsTest do
  use TennisPhx.DataCase

  alias TennisPhx.Events

  describe "tours" do
    alias TennisPhx.Events.Tour

    import TennisPhx.EventsFixtures

    @invalid_attrs %{date: nil, info: nil, title: nil}

    test "list_tours/0 returns all tours" do
      tour = tour_fixture()
      assert Events.list_tours() == [tour]
    end

    test "get_tour!/1 returns the tour with given id" do
      tour = tour_fixture()
      assert Events.get_tour!(tour.id) == tour
    end

    test "create_tour/1 with valid data creates a tour" do
      valid_attrs = %{date: ~N[2021-08-29 12:36:00], info: "some info", title: "some title"}

      assert {:ok, %Tour{} = tour} = Events.create_tour(valid_attrs)
      assert tour.date == ~N[2021-08-29 12:36:00]
      assert tour.info == "some info"
      assert tour.title == "some title"
    end

    test "create_tour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_tour(@invalid_attrs)
    end

    test "update_tour/2 with valid data updates the tour" do
      tour = tour_fixture()
      update_attrs = %{date: ~N[2021-08-30 12:36:00], info: "some updated info", title: "some updated title"}

      assert {:ok, %Tour{} = tour} = Events.update_tour(tour, update_attrs)
      assert tour.date == ~N[2021-08-30 12:36:00]
      assert tour.info == "some updated info"
      assert tour.title == "some updated title"
    end

    test "update_tour/2 with invalid data returns error changeset" do
      tour = tour_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_tour(tour, @invalid_attrs)
      assert tour == Events.get_tour!(tour.id)
    end

    test "delete_tour/1 deletes the tour" do
      tour = tour_fixture()
      assert {:ok, %Tour{}} = Events.delete_tour(tour)
      assert_raise Ecto.NoResultsError, fn -> Events.get_tour!(tour.id) end
    end

    test "change_tour/1 returns a tour changeset" do
      tour = tour_fixture()
      assert %Ecto.Changeset{} = Events.change_tour(tour)
    end
  end
end
