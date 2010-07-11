#!/usr/bin/env ruby
require_relative '../read-ruby'
require 'sinatra'

set :public, ReadRuby::OUT_DIR

helpers do
  def show name
    glob = ReadRuby::OUT_DIR.join(name).to_s + ?*
    send_file Dir[glob].sort_by(&:size).first || halt(404)
  end
end

get '/' do
  show 'index'
end

get '/*' do
  show params[:splat].join(?/)
end
