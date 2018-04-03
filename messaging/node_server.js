#!/usr/bin/env node

var http = require('http')

const host = 'localhost'
const port = 54321

http.createServer( function (req, res) {
	console.log('Received message: ' + req.url)
	res.writeHead( 200 )
	req.on( 'data', function(d) {
		res.write( d )
	})
	req.on( 'end', function() {
		res.end()
	})
    })
    .listen( port )

console.log( 'Server running at http://'+host+':'+port )

