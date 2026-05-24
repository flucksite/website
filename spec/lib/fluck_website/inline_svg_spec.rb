# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "fluck_website/inline_svg"

RSpec.describe FluckWebsite::InlineSvg do
  let(:tmp_dir) { Dir.mktmpdir }
  let(:svg_body) do
    %(<?xml version="1.0"?>\n<svg xmlns="http://www.w3.org/2000/svg" ) +
      %(class="og" fill="red" stroke="blue" stroke-width="2" style="opacity:1" ) +
      %(width="10"><circle/></svg>)
  end

  before do
    FileUtils.mkdir_p(File.join(tmp_dir, "social"))
    File.write(File.join(tmp_dir, "social", "bluesky.svg"), svg_body)
    described_class.instance_variable_set(:@cache, {})
    described_class.search_paths = [tmp_dir]
  end

  after do
    described_class.search_paths = nil
    described_class.instance_variable_set(:@cache, {})
    FileUtils.remove_entry(tmp_dir)
  end

  it "inlines an SVG and strips presentational attributes by default" do
    output = described_class.render("social/bluesky")
    expect(output).to start_with("<svg")
    expect(output).to include('data-inline-svg="social/bluesky"')
    expect(output).not_to include("fill=")
    expect(output).not_to include("style=")
  end

  it "preserves styling attributes when strip_styling: false" do
    output = described_class.render("social/bluesky", strip_styling: false)
    expect(output).to include('fill="red"')
    expect(output).to include('data-inline-svg-styled="social/bluesky"')
  end

  it "injects custom attributes (snake_case → kebab-case) into the <svg>" do
    output = described_class.render("social/bluesky", aria_hidden: "true", class: "x")
    expect(output).to include('aria-hidden="true"')
    expect(output).to include('class="x"')
  end

  it "caches the rendered content per (path, strip_styling) pair" do
    described_class.render("social/bluesky")
    File.write(File.join(tmp_dir, "social", "bluesky.svg"), "<svg><rect/></svg>")
    output = described_class.render("social/bluesky")
    expect(output).to include("<circle")
    expect(output).not_to include("<rect")
  end

  it "raises MissingError when the SVG can't be found" do
    expect { described_class.render("social/nope") }
      .to raise_error(described_class::MissingError, /nope/)
  end
end
