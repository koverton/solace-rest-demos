#!/usr/bin/env node

var http = require('http')
var os   = require('os')

const host = os.hostname( )
const port = 43210

http.createServer( function (req, res) {
	console.log( 'Received request: ' + req.method + " " + req.url )
	res.writeHead( 200 )
	req.on( 'data', function(d) {
		console.log( d.toString('utf-8') )
		res.write( d )
		res.write( '\r\n' )
	})
	req.on( 'end', function() {
		res.end()
	})
    })
    .listen( port )

console.log( 'Server running at http://'+host+':'+port )

