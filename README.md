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

Fork the [GitHub repository](http://github.com/runpaint/read-ruby), make commits and do pull requests.

To generate the book, you'll need:

* Ruby 1.9, which can be installed via [rvm](http://rvm.beginrescueend.com/).
* The gems Mustache, Nokogiri, h5-min, & `pngrammar`: `gem install mustache
  nokogiri h5-min pngrammar`.
* `gzip` for compressing HTML/CSS/JS. Installed by default on most systems.
* `pygments` for highlighting examples. Packaged as `python-pygments` on Debian/Ubuntu. Can also be
  installed with `easy_install Pygments`.
* `optipng` for compressing railroad diagrams. Packaged as `optipng` on Debian/Ubuntu.
* `yuicompressor` for minifying CSS and JS. ([YUI
  Compressor](http://yuilibrary.com/downloads/#yuicompressor))
* Apache 2 for serving local copy. Packaged as `apache2` as Debian/Ubuntu. The
  config file at out/apache.conf should be symlinked from your Apache 2
  `sites-enabled` directory.
* `rsync` for uploading. Packaged as `rsync` on Debian/Ubuntu.
