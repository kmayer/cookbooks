deb = "ruby-enterprise_1.8.7-2009.10_amd64.deb"
set_unless[:ree][:deb] = deb
set_unless[:ree][:project_url] = "http://rubyforge.org/frs/download.php/66163/#{deb}"