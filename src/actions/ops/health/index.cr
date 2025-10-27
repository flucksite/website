class Ops::Health::Index < BrowserAction
  get "/ops/health" do
    plain_text "ok"
  end
end
