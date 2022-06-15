defmodule PaginateSample.Utils.CsvConverter do
  @moduledoc """
  CSV Converter
  """

  @doc ~S"""
  Convert struct lists to CSV

  ## Examples

      iex> import DummyStruct
      iex> records = [%DummyStruct{id: 1, name: :hoge, age: 10}, %DummyStruct{id: 2, name: :fuga, age: 20}, %DummyStruct{id: 3, name: :hogefuga, age: 30}]
      iex> PaginateSample.Utils.CsvConverter.to_csv(records, [:name, :age])
      "name,age\r\nhoge,10\r\nfuga,20\r\nhogefuga,30\r\n"
      iex> PaginateSample.Utils.CsvConverter.to_csv(records, [:age])
      "age\r\n10\r\n20\r\n30\r\n"
      iex> PaginateSample.Utils.CsvConverter.to_csv(records, [:not_found])
      "not_found\r\n\r\n\r\n\r\n"

  """
  def to_csv(records, fields) do
    ([fields] ++ csv_content(records, fields))
    |> NimbleCSV.RFC4180.dump_to_stream()
    |> Enum.join()
  end

  defp csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      fields
      |> Enum.map(&Map.get(record, &1))
    end)
  end
end
