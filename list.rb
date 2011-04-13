require "Command"
require "managerBase"
require "config/config"
class List < Command
 def initialize(server, m_db, config)
    super(server)
    @m_db = m_db
    @config = config
    @query = "select  * from plants"
  end
  def do_stuff_with(request)
    content =  run()
    return 200, "text/xml", content
  end
  def run()
    @xml = Array.new()
    @xml.push('<?xml version="1.0" ?>')
    @xml.push('<herbarium>')
    @xml.push(create_body_xml())
    @xml.push('</herbarium>')
    @xml.to_s
  end
  def create_body_xml()
     @res = @m_db.query(@query)
     @s = Array.new()
     @res.each do |row| p row
          @s.push( "<" +"#{row["name"]}"+ " id=" +'"'+ "#{row["plant_id"]}" + '"' + " level_max=" +'"'+ "#{row["level_max"]}" + '"' +"/>")
     end
     @s
  end
end