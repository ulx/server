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
    @res = @m_db.query(@query)
    @builder = Nokogiri::XML::Builder.new do |xml|
      xml.herbarium {
          @res.each do |row|
            xml.element(:name => "#{row["name"]}", :id => "#{row["plant_id"]}", :level_max => "#{row["level_max"]}")
          end
      }
    end
    return @builder.to_xml
  end

end