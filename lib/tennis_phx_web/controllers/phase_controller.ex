defmodule TennisPhxWeb.PhaseController do
  use TennisPhxWeb, :controller

  alias TennisPhx.Phases
  alias TennisPhx.Phases.Phase

  def index(conn, _params) do
    phases = Phases.list_phases()
    render(conn, "index.html", phases: phases)
  end

  def new(conn, _params) do
    changeset = Phases.change_phase(%Phase{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"phase" => phase_params}) do
    case Phases.create_phase(phase_params) do
      {:ok, phase} ->
        conn
        |> put_flash(:info, "Phase created successfully.")
        |> redirect(to: Routes.phase_path(conn, :show, phase))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    phase = Phases.get_phase!(id)
    render(conn, "show.html", phase: phase)
  end

  def edit(conn, %{"id" => id}) do
    phase = Phases.get_phase!(id)
    changeset = Phases.change_phase(phase)
    render(conn, "edit.html", phase: phase, changeset: changeset)
  end

  def update(conn, %{"id" => id, "phase" => phase_params}) do
    phase = Phases.get_phase!(id)

    case Phases.update_phase(phase, phase_params) do
      {:ok, phase} ->
        conn
        |> put_flash(:info, "Phase updated successfully.")
        |> redirect(to: Routes.phase_path(conn, :show, phase))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", phase: phase, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phase = Phases.get_phase!(id)
    {:ok, _phase} = Phases.delete_phase(phase)

    conn
    |> put_flash(:info, "Phase deleted successfully.")
    |> redirect(to: Routes.phase_path(conn, :index))
  end
end
