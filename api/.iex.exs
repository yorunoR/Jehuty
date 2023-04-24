IO.puts("====-====-====-====-====")
IO.puts(".iex.exs")

IO.puts("* Import Modules")
import Ecto.Query
import Jehuty

IO.puts("* Alias Modules")
alias ExlChain.Index
alias ExlChain.Index.Pinecone
alias Jehuty.Repo
alias Schemas.Account.User
alias Schemas.Chat.Story
alias Schemas.Chat.Chunk
# alias Queries.AccountQuery

IO.puts("====-====-====-====-====")
