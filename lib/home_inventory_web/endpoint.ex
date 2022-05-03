defmodule HomeInventoryWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :home_inventory

  alias Plug.Conn

  @plug_ssl Plug.SSL.init(rewrite_on: [:x_forwarded_proto])

  socket "/live", Phoenix.LiveView.Socket
  socket "/socket", HomeInventoryWeb.Socket

  plug :ping
  plug :canonical_host
  plug :force_ssl
  plug :cors

  plug Plug.Static,
    at: "/",
    from: :home_inventory,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :home_inventory
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug HomeInventoryHealth.Router
  plug(:halt_if_sent)
  plug HomeInventoryWeb.Router

  @doc """
  Callback invoked for dynamically configuring the endpoint.
  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port =
        Application.get_env(:elixir_boilerplate, __MODULE__)[:http][:port] ||
          raise "expected the PORT environment variable to be set"

      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end

  defp ping(%{request_path: "/ping"} = conn, _opts) do
    version = Application.get_env(:home_inventory, :version)
    response = Jason.encode!(%{status: "ok", version: version})

    conn
    |> Conn.put_resp_header("content-type", "application/json")
    |> Conn.send_resp(200, response)
    |> Conn.halt()
  end

  defp ping(conn, _opts), do: conn

  defp canonical_host(%{request_path: "/health"} = conn, _opts), do: conn

  defp canonical_host(conn, _opts) do
    opts =
      PlugCanonicalHost.init(
        canonical_host: Application.get_env(:home_inventory, :canonical_host)
      )

    PlugCanonicalHost.call(conn, opts)
  end

  defp force_ssl(%{request_path: "/health"} = conn, _opts), do: conn

  defp force_ssl(conn, _opts) do
    if Application.get_env(:home_inventory, :force_ssl) do
      Plug.SSL.call(conn, @plug_ssl)
    else
      conn
    end
  end

  defp cors(conn, _opts) do
    opts = Corsica.init(Application.get_env(:home_inventory, Corsica))

    Corsica.call(conn, opts)
  end

  defp halt_if_sent(%{state: :sent, halted: false} = conn, _opts), do: halt(conn)
  defp halt_if_sent(conn, _opts), do: conn
end
