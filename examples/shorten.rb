require "rubygems"
require "shorturl"


def usage
  puts "Usage: #$0 <url> [<service>]"
  puts "Valid services:"
  ShortURL.valid_services.map { |s| s.to_s }.sort.each { |s| puts "\t#{s}" }
end

def main
  begin
    case ARGV.length
    when 0: usage
    when 1: puts ShortURL.shorten(ARGV[0])
    else puts ShortURL.shorten(ARGV[0], ARGV[1].to_sym)
    end
  rescue InvalidService
    puts "Invalid service"
    usage
  end
end


if $0 == __FILE__
  main
end
