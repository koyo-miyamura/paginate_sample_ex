defmodule PaginateSampleWeb.LiveViewTestHelpers do
  @moduledoc """
  Helper for LiveViewTest
  """

  import ExUnit.Assertions
  import ExUnit.CaptureLog

  @doc """
  Assert if target error occurs inside process, e.g. inside handle_event.

      assert_error_inside_process(Ecto.NoResultsError, fn ->
        live
        |> form("#form", valid_form_data)
        |> render_submit()
      end)
  """
  def assert_error_inside_process(exception, fun, capture_log \\ true) when is_function(fun) do
    assert_func = fn ->
      # Note:
      # When error is raised inside live process which is linked to test process, :exit signal is arrived to test process then crashes it.
      # To avoid that, trap :exit signal.
      prev_flag = Process.flag(:trap_exit, true)

      try do
        {{%exit_error_module{}, _stacktrace}, _} = catch_exit(fun.())
        assert exception == exit_error_module
      after
        Process.flag(:trap_exit, prev_flag)
      end
    end

    exec_function(assert_func, capture_log)
  end

  defp exec_function(fun, _capture_log = true) do
    capture_log(fn -> fun.() end)
  end

  defp exec_function(fun, _capture_log = false) do
    fun.()
  end
end
