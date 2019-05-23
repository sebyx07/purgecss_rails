require "purgecss_rails/railtie"
require_relative "./purgecss_rails/builder"

module PurgecssRails
  def self.configure(purge_css_path: "purgecss", &block)
    @@purge_css_path = purge_css_path
    @@configuration = block
    self
  end

  def self.enable!
    @@enabled = true
    self
  end

  def self.run_now!
    return unless @@enabled
    @@configuration.call(PurgecssRails::Builder.new(purge_css_path: @@purge_css_path))
  end
end
