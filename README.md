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

* Ruby 1.9.2 (or 1.9 trunk), which can be installed via
  [rvm](http://rvm.beginrescueend.com/).
* `xsltproc` (Available in an eponymous package on Debian and her derivatives).
* The gems `coderay`, `h5-min`, `nokogiri`, `sinatra`, and `w3c_validators`. If
  you have the `bundler` gem installed, you can install the lot by executing
  `bundle install` in the repository root.
* To validate the DocBook sources you'll need `xmllint` (packaged as
  `libxml2-utils` on Debian et al.) and/or
  [`oNVDL`](http://www.oxygenxml.com/onvdl.html). (Validation will be skipped
  if these programs aren’t installed).
* `gzip` for compressing HTML/CSS/JS. Installed by default on most systems.

To preview it locally:

* Run `rake browse` to start the bundled web server
* Navigate to `http://localhost:4567/`