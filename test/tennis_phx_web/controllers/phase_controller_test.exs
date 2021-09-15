defmodule TennisPhxWeb.PhaseControllerTest do
  use TennisPhxWeb.ConnCase

  import TennisPhx.PhasesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all phases", %{conn: conn} do
      conn = get(conn, Routes.phase_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Phases"
    end
  end

  describe "new phase" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.phase_path(conn, :new))
      assert html_response(conn, 200) =~ "New Phase"
    end
  end

  describe "create phase" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.phase_path(conn, :create), phase: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.phase_path(conn, :show, id)

      conn = get(conn, Routes.phase_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Phase"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.phase_path(conn, :create), phase: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Phase"
    end
  end

  describe "edit phase" do
    setup [:create_phase]

    test "renders form for editing chosen phase", %{conn: conn, phase: phase} do
      conn = get(conn, Routes.phase_path(conn, :edit, phase))
      assert html_response(conn, 200) =~ "Edit Phase"
    end
  end

  describe "update phase" do
    setup [:create_phase]

    test "redirects when data is valid", %{conn: conn, phase: phase} do
      conn = put(conn, Routes.phase_path(conn, :update, phase), phase: @update_attrs)
      assert redirected_to(conn) == Routes.phase_path(conn, :show, phase)

      conn = get(conn, Routes.phase_path(conn, :show, phase))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, phase: phase} do
      conn = put(conn, Routes.phase_path(conn, :update, phase), phase: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Phase"
    end
  end

  describe "delete phase" do
    setup [:create_phase]

    test "deletes chosen phase", %{conn: conn, phase: phase} do
      conn = delete(conn, Routes.phase_path(conn, :delete, phase))
      assert redirected_to(conn) == Routes.phase_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.phase_path(conn, :show, phase))
      end
    end
  end

  defp create_phase(_) do
    phase = phase_fixture()
    %{phase: phase}
  end
end
