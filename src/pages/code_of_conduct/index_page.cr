class CodeOfConduct::IndexPage < MainLayout
  def content
    article class: "prose wrapper flow" do
      markdown r(".text")
    end
  end
end
