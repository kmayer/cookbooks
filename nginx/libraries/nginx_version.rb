module NginxVersion
  require 'open3'
  
  def nginx_version()
    
    @node[:nginx_version] = "0.7.63"
    
    stderr = ''
    cmd = "/usr/local/nginx/sbin/nginx -v"

    Open3.popen3(cmd) do |i,o,e|
     i.close

     while(line = e.gets)
       stderr << line
     end
    end

    version_number = stderr.gsub(/\D/,'').to_i
    major_version = version_number/100

    if major_version == 6
      @node[:nginx][:version] = "0.6.39"
    end

  end
end