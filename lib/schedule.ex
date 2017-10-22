defmodule ExportRuby.Schedule do
  use Export.Ruby

  # Path to ruby files relative to the project root
  @ruby_lib Application.app_dir(:export_ruby, "priv/ruby")
  # Path to ruby executable
  @ruby_exec Application.app_dir(:export_ruby, "priv/ruby/bundle-exec-ruby")

  def daily(start_time, days) do
    # passing simple data types
    arguments = [to_string(start_time), days]

    # Note I'm using `start_link` vs `start` as other examples show.
    # Ensures the ruby process is cleaned up after parent process stops or crashes.
    # This example is not the most efficient technique as this starts and
    # stops a ruby process on EVERY function call, which works but starting and
    # stopping the process each time adds overhead.
    {:ok, ruby} = Ruby.start_link(ruby: @ruby_exec, ruby_lib: @ruby_lib)

    Ruby.call(ruby, "schedule", "daily", arguments)
  end
end
