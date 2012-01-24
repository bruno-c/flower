require 'httparty'
class Surl < Flower::Command
  respond_to "shorten", "surl"

  def self.description
    "Shorten a URL with mnd.to, pass a second param for custom name"
  end

  def self.respond(command, message, sender, flower)
    begin
      if surl(message)['status']
        flower.say(surl['url']['short'], :mention => sender[:id])
      else
        flower.say("It didn't work.\n" + error_messages, :mention => sender[:id])
      end
      @surl = nil
    rescue => error
      puts "#{error.inspect}:\n#{error.backtrace.join("\n")}"
    end
  end

  private
  def self.api_key
    '7d54c7f0ee68f12391bc9ca7f8d4dc3c1fe2ee812e5c2edfcf908f9a812ccdee'
  end

  def self.surl(message = nil)
    @surl ||= make_request(message)
  end

  def self.make_request(message)
    original, short = message.split(' ').map { |str| str.strip }

    body            = {}
    body[:key]      = api_key
    body[:original] = original
    body[:short]    = short unless short.nil? || short.empty?

    HTTParty.post('http://mnd.to/',
      :headers => { 'Accept' => 'application/json' },
      :body    => body
    ).parsed_response
  end

  def self.error_messages
    surl["errors"].keys.map { |key| "#{key}: " + surl["errors"][key].join(", ") }.join("\n")
  end
end
