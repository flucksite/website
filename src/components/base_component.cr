abstract class BaseComponent < Lucky::BaseComponent
  include MarkdownToHTML
  include Localink
  include Turbo
end
