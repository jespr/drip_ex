defmodule Dripex.URI do
  def encode_query(map) do
    Poison.encode!(map)
  end

  defp pair({key, value}) do
    cond do
      Enumerable.impl_for(value) ->
        pair(to_string(key), [], value)
      true ->
        param_name = key |> to_string |> URI.encode_www_form
        param_value = value |> to_string |> URI.encode_www_form

        "#{param_name}=#{param_value}"
    end
  end

  defp pair(root, parents, values) do
    Enum.map_join values, "&", fn {key, value} ->
      cond do
        Enumerable.impl_for(value) ->
          pair(root, parents ++ [key], value)
        false ->
          IO.puts "hrrmmmm"
        true ->
          build_key(root, parents ++ [key]) <> URI.encode_www_form(to_string(value))
      end
    end
  end

  defp build_key(root, parents) do
    path = Enum.map_join parents, "", fn x ->
      param = x |> to_string |> URI.encode_www_form
      "[#{param}]"
    end

    "#{root}#{path}="
  end
end
