class Errors::ShowPage < MainLayout
  needs message : String
  needs status_code : Int32

  def page_title
    r(".page_title").t(status_code: status_code.to_s)
  end

  def page_description
    r(".page_description").t(message: message)
  end

  def content
    div class: "centered" do
      div class: "error | prose flow" do
        h2 status_code, class: "status-code"
        h1 message, class: "message"
        para class: "shift" do
          link r("global.links.back_home").t, to: Home::Index
        end
      end
    end
  end
end
