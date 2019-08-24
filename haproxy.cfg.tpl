#---------------------------------------------------------------------
# Example configuration.  See the full configuration manual online.
#
#   http://www.haproxy.org/download/1.7/doc/configuration.txt
#
#---------------------------------------------------------------------

global
	maxconn     20000
	log         127.0.0.1 local0
	user        haproxy
	chroot      /usr/share/haproxy
	pidfile     /run/haproxy.pid
	daemon

defaults 
	mode http 
	timeout connect 1000ms 
	timeout client 5000ms 
	timeout server 5000ms 

listen stats 
	bind 127.0.0.1:9999 
	stats enable 
	stats hide-version 
	stats uri /stats 
	stats auth admin:admin123 
 
frontend proxy_in 
	bind 127.0.0.1:8888
	use_backend proxies_out

backend proxies_out 
	mode http

	http-check expect status 200

	retry-on all-retryable-errors
	retries 20

	option redispatch
	option httpclose 

	balance roundrobin 

