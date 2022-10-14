# PurgecssRails
Reduce the bloat in your Rails CSS files using PurgeCSS. You can easily configure it to work with most rails apps.

## Installation

First you would need a `purgecss` executable.
you can easily add by:

```bash
yarn add purgecss
```

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

## Usage

Define a file lib/tasks/purge_css.rake and put:

```ruby
require "purgecss_rails"

namespace :purge_css do
  desc "Clear previous CSS files, this busts the CSS cache"
  task :clear do
    `rm public/assets/*.css -rf`
    `rm public/assets/*.css.gz -rf`
  end

  desc "Optimize css files with PurgeCSS"
  task :run do
    PurgecssRails.configure(purge_css_path: "node_modules/purgecss/bin/purgecss") do |purge|
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
PurgecssRails.configure(purge_css_path: `purgecss`) do |purge|
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


If you want to remove unused @keyframes animations or unused css variables add these parameters:
```ruby
  purge.search_css_files("public/assets/**/*.css", ignore: ['rails_admin'], keyframes: true, variables: true)    
```

you can also call `purge.refresh!` and reuse the the `purge` object

## Deployment

Heroku Procfile example

`release: rake purge_css:clear assets:precompile purge_css:run`

Other

`rake purge_css:clear assets:precompile purge_css:run`

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
