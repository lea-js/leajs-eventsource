# leajs-eventsource

Plugin of [leajs](https://github.com/lea-js/leajs-server).

Eventsource implementation.

## leajs.config

```js
module.exports = {

  // …

  // Lookup to translate a url into a eventsource hook
  // $item (Object) Options object, which will have a write function once set up
  // $item.onConnect (Function) Callback which will be called with each new connection
  eventsource: {}, // Object

  // …

}
```

## License
Copyright (c) 2018 Paul Pflugradt
Licensed under the MIT license.
