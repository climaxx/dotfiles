#!/usr/bin/env node
// Usage: keepalive-time <url>
// Measures server HTTP connection keepalive time for <url> by establishing a
// connection, sending one request, receiving one response, and then leaving the
// connection open until the server side closes it.
var sys      = require('sys'),
    http     = require('http'),
    https    = require('https'),
    parseurl = require('url').parse

var url = parseurl(process.argv[2]),
    opts = {
        host: url.host,
        port: url.port || 443,
        path: url.pathname + (url.search || ""),
        headers: {'connection':'Keep-Alive'}
    },
    client = (opts.port == 443 ? https : http)


// The trick here is that node keeps the event loop running after making a
// request until the socket is shutdown, which leads to exit if nothing else
// is scheduled. We record the time, make a request, wait for process exit.
var start = (new Date()).getTime();

client.get(opts, function (res) {
    var size  = 0,
        err   = (res.statusCode != 200)
    console.log("response started: HTTP/" + res.httpVersion + " " + res.statusCode)
    // console.log("headers: " + sys.inspect(res.headers))

    if (res.headers['connection'] == 'close')
        console.log("server explicit disable keep-alive")
    else if (!res.headers['connection'])
        console.log("server implicit enable keep-alive")
    else if (res.headers['connection'].toLowerCase() == "keep-alive")
        console.log("server needless explicit enable keep-alive")

    res.on('data', function (chunk) { size = size + chunk.length })
    res.on('end', function () {
        console.log("response complete: read " + size + " bytes")
        console.log("waiting for keep-alive connection close ...")
    })
    process.on('exit', function () {
        var time = (new Date()).getTime() - start
        console.log("socket connection closed after " + time / 1000.0 + "s")
    })
})
