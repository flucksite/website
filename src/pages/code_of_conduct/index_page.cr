class CodeOfConduct::IndexPage < MainLayout
  def content
    article class: "centered" do
      div class: "prose flow" do
        markdown r(".text").t
      end
    end
  end
end
