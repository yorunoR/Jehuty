defmodule Poems.Scraper do
  use Hound.Helpers

  def run(url, selector) do
    Hound.start_session(
      browser: "chrome",
      user_agent: :chrome,
      driver: %{
        chromeOptions: %{
          args: [
            "--headless",
            "--no-sandbox"
          ]
        }
      }
    )

    navigate_to(url)

    result =
      page_source()
      |> Floki.find(selector)
      |> Floki.text(sep: " ")
      |> String.replace(~r/　/, "")

    {Hound.end_session(), result}
  end
end
