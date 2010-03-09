require 'spec'
require 'mechanize'
require 'open-uri'
require 'zlib'

HOST = 'ruby.runpaint.org'
BASE_URL = URI.parse('http://' + HOST + '/')

class Mechanize
  def visited?(url)
    if url.respond_to?(:fragment)
      url.fragment = nil
    end
    ! visited_page(url).nil?
  end

  def cached_get(url)
    return visited_page(url) if visited?(url)
    get(url)
  end
end

def ua_gzip
  $ua_gzip ||= Mechanize.new
end

def ua_no_gzip
  $ua_no_gzip ||= Mechanize.new.tap{|m| m.gzip_enabled = false}
end

Spec::Matchers.define :be_a_working_link do |expected|
  cached_status = ->(url) do
    begin
      ua_gzip.cached_get(actual).code
    rescue Mechanize::ResponseCodeError => e
      e.response_code
    end.to_i
  end
  
  match do |actual|
    cached_status[actual] == 200
  end
  
  failure_message_for_should do |actual|
    "expected that #{actual} would be a working link; status code: #{cached_status[actual]}"
  end
end
