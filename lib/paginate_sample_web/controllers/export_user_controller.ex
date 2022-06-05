defmodule PaginateSampleWeb.ExportUserController do
  use PaginateSampleWeb, :controller

  alias PaginateSample.Users

  def create(conn, _params) do
    send_download(conn, {:binary, csv_data()}, filename: "export.csv")
  end

  defp csv_data do
    csv_content(users(), fields())
  end

  defp users do
    Users.list_users() |> Map.get(:entries)
  end

  defp fields do
    [:id, :name, :inserted_at, :updated_at]
  end

  defp csv_content(records, fields) do
    data =
      records
      |> Enum.map(fn record ->
        record
        |> Map.from_struct()
        |> Map.take([])
        |> Map.merge(Map.take(record, fields))
        |> Map.values()
      end)

    ([fields] ++ data)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
