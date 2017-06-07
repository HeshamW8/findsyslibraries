require "findsyslibs/version"
require 'net/http'
require 'thor'
require 'rbconfig'
require 'bundler'


module Findsyslibs

	class List < Thor

		API_URL = 'http://app-673ea3e7-1521-4a19-8155-2be54aacd14e.cleverapps.io/'

		desc 'list gemName',
		'list native packages required by the gem'

		def list(gemName)

			platform = os()

			case platform
			when /linux/
				packageManager = 'apt'
			when /macosx/
				packageManager = 'homebrew'
			end

			url = URI.parse(API_URL +  '?name=' + gemName + '&&platform=' + packageManager)
			req = Net::HTTP::Get.new(url.to_s)
			res = Net::HTTP.start(url.host, url.port) {|http|
				http.request(req)
			}

			puts gemName + ' sys dependencies : ' + res.body
		rescue => ex
			$stderr.puts ex.message
		end

		desc 'listGemFile',
		'list native packages required by the gemFile'

		def listGemFile()

			platform = os()

			case platform
			when /linux/
				packageManager = 'apt'
			when /macosx/
				packageManager = 'homebrew'
			end

			lockfile = Bundler::LockfileParser.new(Bundler.read_file(Bundler.default_lockfile))
			
			lockfile.dependencies.each do |key, array|

				url = URI.parse('http://localhost:3000?name=' + array.name + '&&platform=' + packageManager)
				req = Net::HTTP::Get.new(url.to_s)
				res = Net::HTTP.start(url.host, url.port) {|http|
					http.request(req)
				}

				puts array.name + ' sys dependencies : ' + res.body
			end

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
