Read Ruby
=========

_Read Ruby_ is a book I’m writing about Ruby 1.9.2. It’s in a very rough
state, but the latest version can always be viewed at
[ruby.runpaint.org](http://ruby.runpaint.org/).

Text and images are licensed under a [Creative
Commons](http://creativecommons.org/licenses/by-nc-sa/2.0/uk/) license.
Suggestions and issue reports are welcomed via the [Issue
Tracker](http://github.com/runpaint/read-ruby/issues).

Contributor's guide
-------------------

Fork the [GitHub repository](http://github.com/runpaint/read-ruby), make
commits and do pull requests.

To generate the book, you'll need:

* Ruby 1.9, which can be installed via [rvm](http://rvm.beginrescueend.com/).
* The Nokogiri gem. (Optionally, the `h5-min` and `coderay` gem).
* For validation: `xmllint`, `onvdl`, `xlstproc`, and `h5-valid`
* `gzip` for compressing HTML/CSS/JS. Installed by default on most systems.

To preview it locally:

* Install the `sinatra` gem
* Run `rake browse` to start the bundled web server
* Navigate to `http://localhost:4567/`

To upload the site to a remote server you will also need `rsync`.
