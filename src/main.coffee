# just some sample code found on
# http://threejs.org/examples/#webgl_geometry_cube

Storehouse = require './Storehouse.coffee'

window.onload = ->
  document.storehouse = new Storehouse [1,10,4,5,7,2,0]
