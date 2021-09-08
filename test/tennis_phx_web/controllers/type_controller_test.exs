defmodule TennisPhxWeb.TypeControllerTest do
  use TennisPhxWeb.ConnCase

  import TennisPhx.TypesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all types", %{conn: conn} do
      conn = get(conn, Routes.type_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Types"
    end
  end

  describe "new type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.type_path(conn, :new))
      assert html_response(conn, 200) =~ "New Type"
    end
  end

  describe "create type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.type_path(conn, :create), type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.type_path(conn, :show, id)

      conn = get(conn, Routes.type_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.type_path(conn, :create), type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Type"
    end
  end

  describe "edit type" do
    setup [:create_type]

    test "renders form for editing chosen type", %{conn: conn, type: type} do
      conn = get(conn, Routes.type_path(conn, :edit, type))
      assert html_response(conn, 200) =~ "Edit Type"
    end
  end

  describe "update type" do
    setup [:create_type]

    test "redirects when data is valid", %{conn: conn, type: type} do
      conn = put(conn, Routes.type_path(conn, :update, type), type: @update_attrs)
      assert redirected_to(conn) == Routes.type_path(conn, :show, type)

      conn = get(conn, Routes.type_path(conn, :show, type))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, type: type} do
      conn = put(conn, Routes.type_path(conn, :update, type), type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Type"
    end
  end

  describe "delete type" do
    setup [:create_type]

    test "deletes chosen type", %{conn: conn, type: type} do
      conn = delete(conn, Routes.type_path(conn, :delete, type))
      assert redirected_to(conn) == Routes.type_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.type_path(conn, :show, type))
      end
    end
  end

  defp create_type(_) do
    type = type_fixture()
    %{type: type}
  end
end
