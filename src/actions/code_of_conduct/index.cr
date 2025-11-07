class CodeOfConduct::Index < BrowserAction
  # get "/code_of_conduct", "/:locale/code_of_conduct" do
  get "/code_of_conduct" do
    html CodeOfConduct::IndexPage
  end
end
