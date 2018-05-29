module.exports =
  eventsource: 
    type: Object
    default: {}
    desc: "Lookup to translate a url into a eventsource hook"
  eventsource$_item: 
    type: Object
    desc: "Options object, which will have a write function once set up"
  eventsource$_item$onConnect: 
    type: Function
    desc: "Callback which will be called with each new connection"
