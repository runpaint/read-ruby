require 'net/http'

def follow(url)
  chain = []
  while url do
    url = catch(:redirect) do
      chain << url = URI.parse(url)
      resp = Net::HTTP.new(url.host).get url.path
      case resp.code.to_i
        when 200       then return chain.join(' => ')
        when 300...400 then throw :redirect, resp['location']
        else raise "#{url} => #{resp.code}: #{resp.message}"
      end
    end
  end
end
follow('http://w3c.org/html') 
#=> "http://w3c.org/html => http://www.w3.org/html => http://www.w3.org/html/"
