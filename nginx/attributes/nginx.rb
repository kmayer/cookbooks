set_unless[:nginx][:version] = "0.7.64"
set_unless[:nginx][:ssl] = "false"
set_unless[:nginx][:log_format_name] = "combined"
set_unless[:nginx][:log_format] = %q('$remote_addr - $remote_user [$time_local]  '
                    '"$request" $status $body_bytes_sent '
                    '"$http_referer" "$http_user_agent"')