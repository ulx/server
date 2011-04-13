 # require "simple"
 require "rubygems"
 require "command"
 require "image"
 require "init"
 require "dig"
 require "seed"
 require "state"
 require "turn"
 require "list"


begin
class Configureable < Command
  def initialize(server, color, size)
    super(server)
    @color = color
    @size = size
  end
  def do_stuff_with(request)
    content = "<p style=\"color: #{@color}; font-size: #{@size}\">Server run!"
    return 200, "text/html", content
  end
end
if $0 == __FILE__ then
  @m_db = ManagerBD.new()
  @config = ConfigSer.new()
  server = WEBrick::HTTPServer.new(:Port => 8000)
  server.mount "/command", Command
  server.mount "/test", Configureable,  "black", "2em"
  server.mount "/dig", Dig, @m_db, @config
  server.mount "/image", Image, @m_db, @config
  server.mount "/init", Init, @m_db, @config
  server.mount "/seed", Seed, @m_db, @config
  server.mount "/state", State, @m_db, @config
  server.mount "/turn", Turn, @m_db, @config
  server.mount "/list", List, @m_db, @config
   trap "INT" do server.shutdown end
  server.start
end
end



