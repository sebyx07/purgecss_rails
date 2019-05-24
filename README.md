# PurgecssRails
Reduce the bloat in your Rails CSS files using PurgeCSS. You can easily configure it to work with most rails apps.

## Usage

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'purgecss_rails', require: false
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install purgecss_rails
```

Define a file lib/tasks/purge_css.rake and put:

```ruby
    require "purgecss_rails"
    
    desc "PurgeCSS"
    namespace :purge_css do
      task :clear do
        `rm public/assets/*.css -rf`
        `rm public/assets/*.css.gz -rf`
      end
    
      task :run do
        PurgecssRails.configure do |purge|
          purge.search_css_files("public/assets/**/*.css")
    
          purge.match_html_files "public/assets/**/*.js",
                                 "app/views/**/*.html.erb",
                                 "app/helpers/**/*.rb"
    
          purge.optimize!
        end.enable!.run_now!
      end
    end
```

If you need more precision in purging the css, ex engines:

```ruby
    PurgecssRails.configure do |purge|
      purge.search_css_files("public/assets/my_engine/application.css")

      purge.match_html_files "public/assets/my_engine/application.js",
                             "engines/my_engine/views/**/*.html.erb",
                             "app/helpers/**/*.rb"

      purge.optimize!
    end.enable!.run_now!
```

When you are using an external engine and you don't want to purge their css file, add a ingore
```ruby
  purge.search_css_files("public/assets/**/*.css", ignore: ['rails_admin'])    
```


you can also call `purge.refresh!` and reuse the the `purge` object

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
