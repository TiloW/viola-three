Storehouse = require './Storehouse.coffee'

window.onload = ->
  document.storehouse = new Storehouse
    maxItems: 4
    items: [
      [6,3,1,4],
      [2,5,7,8],
      []
    ]

  setTimeout((->
    document.storehouse.promiseTo()
      .relocate(1,2)
      .relocate(1,2)
      .relocate(1,2)
      .relocate(0,2)
      .unload(0)
      .unload(1)
      .unload(0)
      .unload(2)
      .unload(2)
      .unload(0)
      .unload(2)
      .unload(2)
      ), 2000)