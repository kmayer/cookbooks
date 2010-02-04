set_unless[:nginx][:path] = "/usr/sbin"
set_unless[:nginx][:version] = "0.7.65"
set_unless[:nginx][:ssl] = "false"
set_unless[:nginx][:log_format_name] = "default"
set_unless[:nginx][:log_format] = %q('$remote_addr - $remote_user [$time_local]  '
                    '"$request" $status $body_bytes_sent '
                    '"$http_referer" "$http_user_agent"')