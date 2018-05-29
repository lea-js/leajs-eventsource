{test, prepare, Promise, getTestID} = require "snapy"
try
  Lea = require "leajs-server/src/lea"
catch
  Lea = require "leajs-server"
http = require "http"

require "../src/plugin"

port = => 8081 + getTestID()

request = (path = "/", evtsrc) =>
  filter: "headers,statusCode,-headers.date,-headers.last-modified,body"
  stream: "":"body"
  promise: new Promise (resolve, reject) =>
    http.get Object.assign({hostname: "localhost", port: port(), agent: false}, {path: path}), (res) =>
      evtsrc.write "test"
      resolve(res)
      for conn in evtsrc._connections
        conn.end()
    .on "error", reject
  plain: true

prepare (state, cleanUp) =>
  lea = await Lea
    config: Object.assign (state or {}), {
      listen:
        port:port()
      disablePlugins: ["leajs-eventsource"]
      plugins: ["./src/plugin"]
      }
  cleanUp => lea.close()
  return lea

write = null
test {eventsource: "/": null}, (snap, lea) =>
  # file1
  snap request("/",lea.config.eventsource["/"])

