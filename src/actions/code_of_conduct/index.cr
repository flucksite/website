class CodeOfConduct::Index < BrowserAction
  get "/code_of_conduct" do
    html CodeOfConduct::IndexPage
  end
end
