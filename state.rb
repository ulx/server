require "command"
require "managerBase"
require "config/config"
class State < Command
  def initialize(server, m_db, config)
    super(server)
    @m_db = m_db
    @config = config
    @query = @query = "select  field.id, field.x, field.y, field.state_id, plants.name  from field, plants where field.plant_id = plants.plant_id"
  end
  def do_stuff_with(request)
    content =  run()
    return 200, "text/xml", content
  end
  def run()
    @xml = Array.new()
    @xml.push('<?xml version="1.0" ?>')
    @xml.push("<country><field size_x="+ '"' + @config.field_x + '"' + " size_y="+ '"' + @config.field_x + '"' + ' zero_x="0" zero_y="0">')
    @xml.push(create_body_xml())
    @xml.push('</field></country>')
    @xml.to_s
  end
  def create_body_xml()
     @res = @m_db.query(@query)
     @s = Array.new()
     @res.each do |row| p row
          @s.push( "<" +"#{row["name"]}"+ " id=" +'"'+ "#{row["id"]}" + '"' + " state=" + '"' + "#{row["state_id"]}"+ '"' " x=" +'"' "#{row["x"]}" '"'+ " y=" +'"'+ "#{row["y"]}"+ '"' "/>")
     end
    @s
  end
end