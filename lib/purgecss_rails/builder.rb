module PurgecssRails
  class Builder
    def initialize(purge_css_path:)
      @purge_css_executable = purge_css_path
      @css_files = []
    end

    def search_css_files(path)
      @css_files += Dir[path]
      self
    end

    def match_html_files(*paths)
      @html_files_match = paths
      self
    end

    def optimize!
      @result = `#{purge_css_executable} --css #{@css_files.join(" ")} --content #{html_files_match.join(" ")}`
      @result = JSON.parse(result)

      result.each do |result_item|
        file_name = result_item["file"]
        File.write(file_name, result_item["css"])

        zipped = "#{file_name}.gz"

        Zlib::GzipWriter.open(zipped) do |gz|
          gz.mtime = File.mtime(file_name)
          gz.orig_name = file_name
          gz.write IO.binread(file_name)
        end
      end
      self
    end

    def refresh!
      @css_files = []
      @html_files_match = []
    end

    private

    attr_reader :purge_css_executable, :css_files, :html_files_match, :result
  end
end