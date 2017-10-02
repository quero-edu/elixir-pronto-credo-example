defmodule ProntoCredoExample.Example do
  @moduledoc """
  This module serves as an example for
  cyclomatic complex
  """

  def do_something_complex(a, b, c, d, param) do
    g = 0

    e = case param do
      1 ->
        if a == 1 or b == 2 do
          h = 5
        end
      2 -> do_one_thing(a, b) + 1
      _ -> do_another_thing(c, d) - 5
    end

    f = case param do
      1 ->
        if c == 1 or d == 2 do
          g = 7
        end
      2 -> do_one_thing(a, b) * 8
      _ -> do_yet_another_thing(e, f)
    end

    do_one_last_thing(e, f, g)
  end

  def do_one_thing(a, b), do: a + b
  def do_another_thing(c, d), do: c * d
  def do_yet_another_thing(e, f), do: e - f
  def do_one_last_thing(e, f, g), do: e + 2 * f + 5 * g
end
