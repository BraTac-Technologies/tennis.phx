defmodule TennisPhxWeb.TourControllerTest do
  use TennisPhxWeb.ConnCase

  import TennisPhx.EventsFixtures

  @create_attrs %{date: ~N[2021-08-29 12:36:00], info: "some info", title: "some title"}
  @update_attrs %{date: ~N[2021-08-30 12:36:00], info: "some updated info", title: "some updated title"}
  @invalid_attrs %{date: nil, info: nil, title: nil}

  describe "index" do
    test "lists all tours", %{conn: conn} do
      conn = get(conn, Routes.tour_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tours"
    end
  end

  describe "new tour" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tour_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tour"
    end
  end

  describe "create tour" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tour_path(conn, :create), tour: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tour_path(conn, :show, id)

      conn = get(conn, Routes.tour_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tour"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tour_path(conn, :create), tour: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tour"
    end
  end

  describe "edit tour" do
    setup [:create_tour]

    test "renders form for editing chosen tour", %{conn: conn, tour: tour} do
      conn = get(conn, Routes.tour_path(conn, :edit, tour))
      assert html_response(conn, 200) =~ "Edit Tour"
    end
  end

  describe "update tour" do
    setup [:create_tour]

    test "redirects when data is valid", %{conn: conn, tour: tour} do
      conn = put(conn, Routes.tour_path(conn, :update, tour), tour: @update_attrs)
      assert redirected_to(conn) == Routes.tour_path(conn, :show, tour)

      conn = get(conn, Routes.tour_path(conn, :show, tour))
      assert html_response(conn, 200) =~ "some updated info"
    end

    test "renders errors when data is invalid", %{conn: conn, tour: tour} do
      conn = put(conn, Routes.tour_path(conn, :update, tour), tour: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tour"
    end
  end

  describe "delete tour" do
    setup [:create_tour]

    test "deletes chosen tour", %{conn: conn, tour: tour} do
      conn = delete(conn, Routes.tour_path(conn, :delete, tour))
      assert redirected_to(conn) == Routes.tour_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.tour_path(conn, :show, tour))
      end
    end
  end

  defp create_tour(_) do
    tour = tour_fixture()
    %{tour: tour}
  end
end
