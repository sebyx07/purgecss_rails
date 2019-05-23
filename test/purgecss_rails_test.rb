require 'test_helper'

class PurgecssRails::Test < ActiveSupport::TestCase
  setup do
    `rm -rf ./test/dummy/public/assets/*`
    `cd test/dummy && rake assets:precompile`
  end

  def test_configure
    PurgecssRails.configure(purge_css_path: "purgecss") do |b|
      b.search_css_files("./test/dummy/public/assets/*.css")

      b.match_html_files "./test/dummy/app/views/**/*.html.erb",
                         "./test/dummy/public/assets/**/*.js",
                         "./test/dummy/app/helpers/**/*.rb"

      b.optimize!.refresh!
    end.enable!.run_now!

    css_file = Dir['./test/dummy/public/assets/*.css'].first
    output_css = File.read(css_file)

    assert_not output_css.include?("unused")
    assert output_css.include?("used-html")
    assert output_css.include?("used-js")
    assert output_css.include?("used-helper")
  end
end
