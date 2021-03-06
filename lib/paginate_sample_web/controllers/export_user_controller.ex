defmodule PaginateSampleWeb.ExportUserController do
  use PaginateSampleWeb, :controller

  alias PaginateSample.Users
  alias PaginateSample.Utils.CsvConverter

  def create(conn, _params) do
    send_download(conn, {:binary, csv_data()}, filename: "export.csv")
  end

  defp csv_data() do
    CsvConverter.to_csv(users(), fields())
  end

  defp users do
    Users.list_all_users()
  end

  defp fields do
    [:id, :name, :inserted_at, :updated_at]
  end
end
