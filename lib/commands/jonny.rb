require 'nokogiri'
class Jonny < Flower::Command
  respond_to "jonny", "tfd", "javve"
  listen_to /.* (tfd|javve)(\s|$|\.).*/i
  URL = "http://thatswhatjonnysaid.com/random"

  def self.description
    "Post a random jony quote"
  end

  def self.listen(message)
    message.say(quote, :mention => message.user_id)
  end

  def self.respond(message)
    message.say(quote)
  end

  def self.quote
    document = Nokogiri.HTML(Typhoeus::Request.get(URL, :follow_location => true).body)
    "#{document.at_css(".thequote").text}\n- #{document.at_css(".source").text} #thatswhatjonnysaid"
  end
end
