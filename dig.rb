require "Command"
require "managerBase"
require "config/config"
class Dig < Command
  def initialize(server, m_db, config)
    super(server)
    @color = "red"
    @size = "2em"
    @m_db = m_db
    @config = config
    @field_x = -1
    @field_y = -1

  end

  def do_stuff_with(request)
    if !verify_field(request.path_info.to_s) then
      content = "<p style=\"color: #{@color}; font-size: #{@size}\">Error nomer field 0 < x < " + @config.field_x + " and field 0 < y < " + @config.field_y
      return 200, "text/html", content
    end
    @query = "delete from field where field.x = "+ @field_x.to_s + " and " + "field.y = " + @field_y.to_s
    digField()
    content = "<p style=\"color: #{@color="black"}; font-size: #{@size}\">Delete field_x = " + @field_x.to_s + " field_y = " + @field_y.to_s
    return 200, "text/html", content
  end

  def verify_field(url)
    list = url.split("/")
    if list.length != 3 then
      return false
    end
    @field_x = list[1]
    @field_y = list[2]
    if  ((-1 < @field_x.to_i) && (-1 < @field_y.to_i) && (@config.field_x.to_i > @field_x.to_i) && (@config.field_y.to_i > @field_y.to_i))
      return true
    end
    return false
  end
  def digField()
      @m_db.query(@query)
  end
end