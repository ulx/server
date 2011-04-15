require 'singleton'

class ConfigSer
  attr_accessor   :user, :pass, :db, :field_x, :field_y, :dir, :backround
  attr_accessor  :host, :port

  def initialize()
    p = Array.new()
    p = self.init
    @user = p["user"]
    @pass = p["pass"]
    @db = p["db"]
    @host = p["host"]
    @port = p["port"]
    @field_x = p["field_x"]
    @field_y = p["field_y"]
    @dir = p["dir"]
    @backround = p["backround"]
  end

  def init(properties_filename =  "config/config.ini")
        properties = {}
    File.open(properties_filename, 'r') do |properties_file|
      properties_file.read.each_line do |line|
        line.strip!
        if (line[0] != ?# and line[0] != ?=)
          i = line.index('=')
          if (i)
            properties[line[0..i - 1].strip] = line[i + 1..-1].strip

          else
            properties[line] = ''
          end
        end
      end
    end
        return properties
  end
end
