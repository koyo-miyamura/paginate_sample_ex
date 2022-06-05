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
    Users.list_all_users()
  end

  defp fields do
    [:id, :name, :inserted_at, :updated_at]
  end

  defp csv_content(records, fields) do
    data = records |> Enum.map(&fetch_by_fields_order(&1, fields))

    ([fields] ++ data)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end

  defp fetch_by_fields_order(record, fields) do
    fields |> Enum.map(fn field -> Map.fetch!(record, field) end)
  end
end
