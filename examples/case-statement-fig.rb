MAX_REDIRECTS = 5
redirects = 0
[200, 404, 408, 302, 500].map do |status_code|
  case status_code
    when 408, 504  then :timeout
    when 100...200 then :informational
    when 200...300 then :success
    when 300...400
      (redirects += 1) < MAX_REDIRECTS ? :redirection 
                                       : (raise "Redirection limit exceeded")
    when 400...500 then :client_error
    when 500...600 then :server_error
    else                raise "Invalid status code: #{status_code}"
  end
end #=> [:success, :client_error, :timeout, :redirection, :server_error]
