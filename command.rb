require 'webrick'
include WEBrick
begin
  class Command < WEBrick::HTTPServlet::AbstractServlet
    def do_GET(request, response)
     status, content_type, body = do_stuff_with(request)

      response.status = status
      response['Content-Type'] = content_type
      response.body = body
    end

    def do_stuff_with(request)
      return 200, "text/plain", "you got a page Command"
    end

  end
end





