require 'cinch'
require 'yaml'
require 'elasticsearch'

module ESIRCBot
  class CLI
    def self.run
      config = YAML::load_file(File.expand_path('../../../config/settings.yml', __FILE__))

      bot = Cinch::Bot.new do
        configure do |c|
          c.server = config["server"]
          c.nick = config["nick"]
          c.channels = config["channels"]
        end
      end

      es = Elasticsearch::Client.new log: true

      bot.on :channel do |m|
        es.create index: 'irc',
                  type: 'log',
                  body: {
                          channel: m.channel.name,
                          command: m.command,
                          nick: m.user.nick,
                          message: m.message,
                          raw: m.raw,
                          time: m.time.iso8601
                        }
      end

      trap "SIGINT" do
        bot.quit
      end

      bot.start
    end
  end
end
