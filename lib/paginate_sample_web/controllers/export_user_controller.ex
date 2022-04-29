defmodule PaginateSampleWeb.ExportUserController do
  use PaginateSampleWeb, :controller

  alias PaginateSample.Users

  def create(conn, _params) do
    fields = [:id, :name, :inserted_at, :updated_at]
    csv_data = csv_content(Users.list_users() |> Map.get(:entries), fields)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
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
