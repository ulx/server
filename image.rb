require "command"
require "config/config"
require "managerBase"
class Image < Command

  def initialize(server, m_db, config)
    super(server)

    @m_db = m_db
    @config = config
    @query_plant_name = "select name from plants where plant_id = "
    @query_filename = "select sprite_name from plant_states where state_id = "
    @c_type = Hash.new()
    @palnt_id = -1
    @state_id = -1
    @plant_name
    @filename
    @filepath = "static"
    @file_dir_image = "/Images/"
  end

  def do_stuff_with(request)
    type_content, f = run (request.path_info.to_s)
    return 200, type_content, f
  end

  def run(url)
    @c_type["png"] = "Images/png"
    @c_type["jpg"] = "image/jpeg"
    @c_type["gif"] ="image/gif"
    @c_type["ico"] = "image/x-icon"
    set_parametr(url)
    @ext = @filepath.split('.')[-1] # get extension
    f = File.new(@filepath, 'rb').read()
    return @c_type[@ext], f
  end

  def set_parametr(url)
    list = url.split("/")
    if list.length == 0 then
       @filepath = @filepath + "/" + "BG.jpg"
      return
    end

    if list.length == 2 then
       @plant_id = list[1]
       @state_id = 1
       @plant_name = set_plant_name()
       @filename = set_file_name()
       @filepath = @filepath + "/" + @plant_name + @file_dir_image + @filename
    return
    end
     if list.length == 3 then
    @plant_id = list[1]
    @state_id = list[2]
    end
    if (@plant_id.to_i != -1)&&(@state_id.to_i != -1) then
      @plant_name = set_plant_name()
      @filename = set_file_name()
      @filepath = @filepath + "/" + @plant_name + @file_dir_image + @filename
    end


  end

  def set_plant_name()
    @res = @m_db.query(@query_plant_name + @plant_id.to_s)
    @res.each do |row|
      @s = "#{row["name"]}"
    end
    @s
  end

  def set_file_name()
    @res = @m_db.query(@query_filename + @state_id.to_s)
    @res.each do |row|
      @s = "#{row["sprite_name"]}"
    end
    @s
  end

end