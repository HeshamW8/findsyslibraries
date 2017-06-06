require "findsyslibs/version"
require 'net/http'
require 'thor'

module Findsyslibs

	class List < Thor

		desc 'list gemName',
		'list native packages required by the gem'
		method_option :gemfile, default: 'Gemfile',
		desc: 'find native packages required by gems in the gem file'

		def list(gemName)
			url = URI.parse('http://localhost:3000?name=' + gemName + '&&platform=apt')
			req = Net::HTTP::Get.new(url.to_s)
			res = Net::HTTP.start(url.host, url.port) {|http|
				http.request(req)
			}
			puts res.body
		rescue => ex
			$stderr.puts ex.message
		end
	end

end