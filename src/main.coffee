Storehouse = require './Storehouse.coffee'

window.onload = ->
  document.storehouse = new Storehouse
    items: [6,7,4,5,2,1,4,0]
    maxItems: 7