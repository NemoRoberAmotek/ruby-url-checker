require "csv"
require "net/http"

array = CSV.read(ARGV[0])

nok_array = []

array.each do |row|
    uri = URI(row[0])
    response = Net::HTTP.get_response(uri)
    print('.')

    next if response.instance_of?(Net::HTTPOK)
    next if response.instance_of?(Net::HTTPMovedPermanently)

    nok_array << row[0]
end

puts
puts(nok_array)
nok_array.length === 0 && puts("All provided URL's are successful (either Status Code 200 or 301)")

