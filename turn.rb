require "Command"
require "managerBase"
require "config/config"
require 'open-uri'
require 'nokogiri'
class Turn  < Command
   def initialize(server, m_db, config)
    super(server)
    @m_db = m_db
    @config = config
    @query_select = "select  field.id, field.x, field.y, field.state_id, plants.name  from field, plants where field.plant_id = plants.plant_id"
    @query_update = "update  field set state_id=state_id+1  where  field.state_id < (select level_max from plants where field.plant_id = plants.plant_id)"
  end
  def do_stuff_with(request)
    content =  run()
    return 200, "text/xml", content
  end
  def run()
     turn_sql()
     @res = @m_db.query(@query_select)
    @builder = Nokogiri::XML::Builder.new do |xml|
      xml.country {
        xml.field('size_x'=> @config.field_x, 'size_y'=> @config.field_y, 'zero_x'=>'0', 'zero_y'=>'0') {
          @res.each do |row|
            xml.element(:name => "#{row["name"]}", :id => "#{row["id"]}", :state => "#{row["state_id"]}", :x=>"#{row["x"]}", :y=>"#{row["y"]}")
          end
        }
      }
    end
    return @builder.to_xml
  end

  def turn_sql()
     @m_db.query(@query_update)
  end
end