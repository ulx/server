require "Command"
require "managerBase"
require "config/config"
class Seed  < Command
    def initialize(server, m_db, config)
    super(server)
    @color = "red"
    @size = "2em"
    @m_db = m_db
    @config = config
    @x = -1
    @y = -1
    @plant_id = -1
    @state_id = 5

  end

  def do_stuff_with(request)
    if !verify_field(request.path_info.to_s) then
      content = "<p style=\"color: #{@color}; font-size: #{@size}\">Error nomer field 0 < x < " + @config.field_x + " and field 0 < y < " + @config.field_y
      return 200, "text/html", content
    end
    @query = "INSERT INTO field (x, y, plant_id, state_id)VALUES ("+ @x.to_s + " ," + @y.to_s + ", " + @plant_id.to_s + "," + @state_id.to_s +  ")"
    digField()
    content = "<p style=\"color: #{@color="black"}; font-size: #{@size}\">Add field <br> x = " + @x.to_s + "<br> y = " + @y.to_s + "<br> plant_id = " + @plant_id.to_s + "<br> state_id = " + @state_id.to_s
    return 200, "text/html", content
  end

  def verify_field(url)
    list = url.split("/")
    if list.length != 4 then
      return false
    end
    @x = list[1]
    @y = list[2]
    @plant_id = list[3]
    if (@plant_id.to_i - 2) == 0 then  @state_id = 1 end
    if (@plant_id.to_i - 3) == 1 then  @state_id = 5 end
    if (@plant_id.to_i - 4) == 2 then  @state_id = (@plant_id.to_i - 4)*5 end
    if  ((-1 < @x.to_i) && (-1 < @y.to_i) && (@config.field_x.to_i > @x.to_i) && (@config.field_y.to_i > @y.to_i))
      return true
    end
    return false
  end
  def digField()
      @m_db.query(@query)
  end
end