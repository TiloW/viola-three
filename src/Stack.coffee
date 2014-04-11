Item = require './Item.coffee'

module.exports = class Stack
  @HEIGHT: 10

  constructor: (options) ->
    @items = []
    @scene = options.scene
    @maxItems = options.maxItems
    @geometry = new THREE.BoxGeometry(Item.WIDTH, Stack.HEIGHT, Item.WIDTH)
    @texture = THREE.ImageUtils.loadTexture('textures/stack.gif')
    @texture.anisotropy = 4
    @material = new THREE.MeshBasicMaterial(map: @texture)
    @mesh = new THREE.Mesh(@geometry, @material)

    @mesh.position = options.position

    @scene.add @mesh

  addItem: (item, callback) ->
    itemCounter = @items.length
    stackIsFull = itemCounter >= @maxItems
    unless stackIsFull
      pos =
        x: @mesh.position.x
        y: @getTopPosY()
        z: @mesh.position.z

      item?.mesh.position = pos
      item ?= new Item
        scene: @scene
        position: pos
      @items.push item

    callback?()
    not stackIsFull

  unload: (callback) ->
    item = @_getTopItem()
    if item
      setTimeout((=> @_removeItem(item, callback)), 2000);
      @items = @items[0..-2]

      animate = ->
        if item.mesh.position
          requestAnimationFrame(animate)
        item.mesh.position.y += Item.HEIGHT/10
      animate()

    item?

  relocateTo: (otherStack, callback) ->
    item = @_getTopItem()
    canRelocate = not @isEmpty() and otherStack? and not otherStack.isFull() and otherStack isnt @
    if canRelocate
      MOVE_SIZE = Item.HEIGHT/10
      needsLiftingUp = true
      needsShiftingX = true
      needsShiftingZ = true
      needsLowering = true

      animate = =>
        if needsLowering
          requestAnimationFrame(animate)
        else
          @items = @items[0..-2]
          otherStack.addItem item
          callback?()

        needsLiftingUp &= item.mesh.position.y < (@maxItems+2) * Item.HEIGHT
        item.mesh.position.y += MOVE_SIZE if needsLiftingUp
        unless needsLiftingUp
          needsShiftingX &= Math.abs(item.mesh.position.x - otherStack.mesh.position.x) > MOVE_SIZE
          needsShiftingZ &= Math.abs(item.mesh.position.z - otherStack.mesh.position.z) > MOVE_SIZE
          item.mesh.position.x += Item.HEIGHT/10 * (if otherStack.mesh.position.x > item.mesh.position.x then 1 else -1) if needsShiftingX
          item.mesh.position.z += Item.HEIGHT/10 * (if otherStack.mesh.position.z > item.mesh.position.z then 1 else -1) if needsShiftingZ

          unless needsShiftingX or needsShiftingZ
            item.mesh.position.x = (item.mesh.position.x + otherStack.mesh.position.x)/2
            item.mesh.position.z = (item.mesh.position.z + otherStack.mesh.position.z)/2
            needsLowering &= item.mesh.position.y - otherStack.getTopPosY() > MOVE_SIZE
            item.mesh.position.y -= MOVE_SIZE

      animate()

    callback?() unless canRelocate
    canRelocate

  isFull: ->
    @items.length is @maxItems

  isEmpty: ->
    @items.length is 0

  getTopPosY: ->
    @mesh.position.y + Stack.HEIGHT/2 + (@items.length+.5)*Item.HEIGHT

  _getTopItem: ->
    @items[-1..][0]

  _removeItem: (item, callback) ->
    @scene.remove item.mesh
    callback?()