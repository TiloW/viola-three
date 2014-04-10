Item = require './Item.coffee'

module.exports = class Stack
  @HEIGHT: 10

  constructor: (@scene, @position) ->
    @items = []
    @geometry = new THREE.BoxGeometry(Item.WIDTH, Stack.HEIGHT, Item.WIDTH)
    @texture = THREE.ImageUtils.loadTexture('textures/stack.gif')
    @texture.anisotropy = 4
    @material = new THREE.MeshBasicMaterial(map: @texture)
    @mesh = new THREE.Mesh(@geometry, @material)

    @mesh.position = @position

    @scene.add @mesh

  addItem: ->
    itemCounter = @items.length
    position =
      x: @position.x
      y: itemCounter*Item.HEIGHT + Stack.HEIGHT*3/2
      z: @position.z
    @items.push new Item(@scene, position)

  unload: ->
    item = @items[-1..][0]
    setTimeout((=> @_removeItem(item)), 2000);
    @items = @items[0..-2]

    animate = ->
      requestAnimationFrame(animate)
      item.mesh.position.y += Item.HEIGHT/10
    animate()

  _removeItem: (item) ->
    @scene.remove item.mesh
