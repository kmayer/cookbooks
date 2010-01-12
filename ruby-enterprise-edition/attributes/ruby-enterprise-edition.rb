if kernel[:machine] == "x86_64"
  deb = "ruby-enterprise_1.8.7-2009.10_amd64.deb"
  set_unless[:ree][:project_url] = "http://rubyforge.org/frs/download.php/66163/#{deb}"
  set_unless[:ree][:checksum] = "c6d1489b"
else
  deb = "ruby-enterprise_1.8.7-2009.10_i386.deb"
  set_unless[:ree][:project_url] = "http://rubyforge.org/frs/download.php/66164/#{deb}"
  set_unless[:ree][:checksum] = "f87da507"
end

set_unless[:ree][:deb] = deb