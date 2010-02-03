if kernel[:machine] == "x86_64"
  deb = "ruby-enterprise_1.8.7-2010.01_amd64.deb"
  set_unless[:ree][:project_url] = "http://rubyforge.org/frs/download.php/68720/#{deb}"
  set_unless[:ree][:checksum] = "2e682eb9"
else
  deb = "ruby-enterprise_1.8.7-2010.01_i386.deb"
  set_unless[:ree][:project_url] = "http://rubyforge.org/frs/download.php/68718/#{deb}"
  set_unless[:ree][:checksum] = "0465bd70"
end

set_unless[:ree][:deb] = deb