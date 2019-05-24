module PurgecssRails
  class Builder
    def initialize(purge_css_path:)
      @purge_css_executable = purge_css_path
      @css_files = []
    end

    def search_css_files(path, ignore: [])
      @css_files += Dir[path]
      @ignored_names = ignore
      self
    end

    def match_html_files(*paths)
      @html_files_match = paths
      self
    end

    def ignore_files
      return @ignore_files if @ignore_files.present?
      @ignore_files = @css_files.select do |f|
        included = true
        @ignored_names.each do |ignored_name|
          if f.include?(ignored_name)
            break included = false
          end
        end
        included
      end
    end

    def optimize!
      print "\n"
      ignore_files.each do |f|
        print "purging #{f}\n"
      end

      @result = `#{purge_css_executable} --css #{ignore_files.join(" ")} --content #{html_files_match.join(" ")}`
      @result = JSON.parse(result)

      result.each do |result_item|
        file_name = result_item["file"]
        File.write(file_name, result_item["css"])

        zipped = "#{file_name}.gz"
        print "zipping #{zipped}\n"

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
      @ignore_files = []
    end

    private

    attr_reader :purge_css_executable, :css_files, :html_files_match, :result
  end
end