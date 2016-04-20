require 'sensu-plugin/check/cli'

class CheckThinpool < Sensu::Plugin::Check::CLI
	option :warn,
		short: '-w WARN',
		default: 75.00

	option :crit,
		short: '-c CRIT',
		default: 90.00

	def initialize
		super
		@crit_lvm = []
		@warn_lvm = []
	end

	def lvm_thinpools
		lvs_output = `lvs --noheadings --separator : -o lv_attr,lv_name,data_percent,metadata_percent`
		thinpools = Array.new
		lvs_output.split("\n").each do |line|
			lv_array = line.split(":")
			if lv_array[0].include? 't'
				lv_hash = Hash.new
				lv_hash['lv_attr'] = lv_array[0]
				lv_hash['lv_name'] = lv_array[1]
				lv_hash['data_percent'] = lv_array[2].to_f
				lv_hash['metadata_percent'] = lv_array[3].to_f
				thinpools.push(lv_hash)
			end
		end
		return thinpools
	end

	def check_thinpools
		lvm_thinpools.each do |lvm_thinpool|
			if lvm_thinpool['data_percent'] >= config[:crit]
         	@crit_lvm << "#{lvm_thinpool['lv_name']} #{lvm_thinpool['data_percent']}% data"
         elsif lvm_thinpool['metadata_percent'] >= config[:crit]
         	@crit_lvm << "#{lvm_thinpool['lv_name']} #{lvm_thinpool['metadata_percent']}% metadata"
         elsif lvm_thinpool['data_percent'] >= config[:warn]
         	@warn_lvm << "#{lvm_thinpool['lvm_thinpool']} #{lvm_thinpool['data_percent']}% data"
         elsif lvm_thinpool['metadata_percent'] >= config[:warn]
         	@warn_lvm << "#{lvm_thinpool['lv_name']} #{lvm_thinpool['metadata_percent']}% metadata"
			end
		end 
	end

	def usage_summary
		(@crit_lvm + @warn_lvm).join(', ')
	end

	def run
		check_thinpools
		critical usage_summary unless @crit_lvm.empty?
		warning usage_summary unless @warn_lvm.empty?
		ok "All thinpool usage under #{config[:warn]}%"
	end 
	
end