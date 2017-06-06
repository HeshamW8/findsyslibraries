require "findsyslibs/version"
require 'net/http'
require 'thor'
require 'devise'
require 'rbconfig'


module Findsyslibs

	class List < Thor

		desc 'list gemName',
		'list native packages required by the gem'
		method_option :gemfile, default: 'Gemfile',
		desc: 'find native packages required by gems in the gem file'

		def list(gemName)

			platform = os()

			case platform
			when /linux/
				packageManager = 'apt'
			when /macosx/
				packageManager = 'homebrew'
			end

			url = URI.parse('http://localhost:3000?name=' + gemName + '&&platform=' + packageManager)
			req = Net::HTTP::Get.new(url.to_s)
			res = Net::HTTP.start(url.host, url.port) {|http|
				http.request(req)
			}
			
			puts res.body
		rescue => ex
			$stderr.puts ex.message
		end

		def os
			@os ||= (
				host_os = RbConfig::CONFIG['host_os']
				case host_os
				when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
					:windows
				when /darwin|mac os/
					:macosx
				when /linux/
					:linux
				when /solaris|bsd/
					:unix
				else
					raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
				end
				)
			return @os
		end
	end

end