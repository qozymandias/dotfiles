#!/usr/bin/python2

import sys
import BaseHTTPServer
from SimpleHTTPServer import SimpleHTTPRequestHandler

ADDR ='10.204.65.193'
# ADDR ='10.120.232.50'

HandlerClass = SimpleHTTPRequestHandler
ServerClass  = BaseHTTPServer.HTTPServer
Protocol     = "HTTP/1.0"

if sys.argv[1:]:
    port = int(sys.argv[1])
else:
    port = 8000
server_address = (ADDR, port)

HandlerClass.protocol_version = Protocol
httpd = ServerClass(server_address, HandlerClass)

sa = httpd.socket.getsockname()
print "Serving HTTP on", sa[0], "port", sa[1], "..."
httpd.serve_forever()
