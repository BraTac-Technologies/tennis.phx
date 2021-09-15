defmodule TennisPhx.PhasesTest do
  use TennisPhx.DataCase

  alias TennisPhx.Phases

  describe "phases" do
    alias TennisPhx.Phases.Phase

    import TennisPhx.PhasesFixtures

    @invalid_attrs %{name: nil}

    test "list_phases/0 returns all phases" do
      phase = phase_fixture()
      assert Phases.list_phases() == [phase]
    end

    test "get_phase!/1 returns the phase with given id" do
      phase = phase_fixture()
      assert Phases.get_phase!(phase.id) == phase
    end

    test "create_phase/1 with valid data creates a phase" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Phase{} = phase} = Phases.create_phase(valid_attrs)
      assert phase.name == "some name"
    end

    test "create_phase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Phases.create_phase(@invalid_attrs)
    end

    test "update_phase/2 with valid data updates the phase" do
      phase = phase_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Phase{} = phase} = Phases.update_phase(phase, update_attrs)
      assert phase.name == "some updated name"
    end

    test "update_phase/2 with invalid data returns error changeset" do
      phase = phase_fixture()
      assert {:error, %Ecto.Changeset{}} = Phases.update_phase(phase, @invalid_attrs)
      assert phase == Phases.get_phase!(phase.id)
    end

    test "delete_phase/1 deletes the phase" do
      phase = phase_fixture()
      assert {:ok, %Phase{}} = Phases.delete_phase(phase)
      assert_raise Ecto.NoResultsError, fn -> Phases.get_phase!(phase.id) end
    end

    test "change_phase/1 returns a phase changeset" do
      phase = phase_fixture()
      assert %Ecto.Changeset{} = Phases.change_phase(phase)
    end
  end
end
