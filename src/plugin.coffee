
module.exports = ({init}) => init.hookIn ({
  config:{eventsource}, 
  respond, 
  position}) =>

  if Object.keys(eventsource).length > 0
    for k,v of eventsource
      eventsource[k] = v = {} unless v?
      tmp = v._connections = []
      v.write = ((conns, msg) =>
        for con in conns
          con.write(msg)
          con.write("\n\n")
        ).bind(null,tmp)
     
    respond.hookIn position.after, (req) =>
      if not req.body? and not req.file? and (evts = eventsource[(url = req.url)])?
        (socket = req.request.socket).setKeepAlive(true)
        (conns = evts._connections).push (resp = req.response)
        head = req.head
        head.contentType = "text/event-stream"
        head.cacheControl = "no-cache"
        head.connection = "keep-alive"
        req.encode = false
        req.body = "\n"
        if evts.onConnect
          req.end.hookIn req.position.end, =>
            evts.onConnect resp
        socket.on "close", =>
          conns.splice(i,1) if ~(i = conns.indexOf(resp))
          
module.exports.configSchema = require("./configSchema")