require 'rubygems'
require 'pg'
require 'singleton'
require "config/config"


class ManagerBD
  attr_accessor :conn
  def initialize()
    config = ConfigSer.new()
    @conn = PGconn.connect(config.host, config.port, '', '', config.db, config.user, config.pass)
  end
  def query(s)
      @res = conn.exec(s)
     @res
  end
  def close_connect()
       @conn.close unless @conn.nil?
       puts "Connection closed"
  end
  def close_query()
     @res.close unless @conn.nil?
     puts "Connection closed"
  end
  def open(host, port, db, user, pass)
    @conn = PGconn.connect(host, port.to_i, '', '', db, user, pass)
  end
end


