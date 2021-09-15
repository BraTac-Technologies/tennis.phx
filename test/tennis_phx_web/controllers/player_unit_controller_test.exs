defmodule TennisPhxWeb.Player_unitControllerTest do
  use TennisPhxWeb.ConnCase

  import TennisPhx.PlayerUnitsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all player_units", %{conn: conn} do
      conn = get(conn, Routes.player_unit_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Player units"
    end
  end

  describe "new player_unit" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.player_unit_path(conn, :new))
      assert html_response(conn, 200) =~ "New Player unit"
    end
  end

  describe "create player_unit" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.player_unit_path(conn, :create), player_unit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.player_unit_path(conn, :show, id)

      conn = get(conn, Routes.player_unit_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Player unit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.player_unit_path(conn, :create), player_unit: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Player unit"
    end
  end

  describe "edit player_unit" do
    setup [:create_player_unit]

    test "renders form for editing chosen player_unit", %{conn: conn, player_unit: player_unit} do
      conn = get(conn, Routes.player_unit_path(conn, :edit, player_unit))
      assert html_response(conn, 200) =~ "Edit Player unit"
    end
  end

  describe "update player_unit" do
    setup [:create_player_unit]

    test "redirects when data is valid", %{conn: conn, player_unit: player_unit} do
      conn = put(conn, Routes.player_unit_path(conn, :update, player_unit), player_unit: @update_attrs)
      assert redirected_to(conn) == Routes.player_unit_path(conn, :show, player_unit)

      conn = get(conn, Routes.player_unit_path(conn, :show, player_unit))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, player_unit: player_unit} do
      conn = put(conn, Routes.player_unit_path(conn, :update, player_unit), player_unit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Player unit"
    end
  end

  describe "delete player_unit" do
    setup [:create_player_unit]

    test "deletes chosen player_unit", %{conn: conn, player_unit: player_unit} do
      conn = delete(conn, Routes.player_unit_path(conn, :delete, player_unit))
      assert redirected_to(conn) == Routes.player_unit_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.player_unit_path(conn, :show, player_unit))
      end
    end
  end

  defp create_player_unit(_) do
    player_unit = player_unit_fixture()
    %{player_unit: player_unit}
  end
end
