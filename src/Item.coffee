module.exports = class Item
  @HEIGHT: 30
  @WIDTH: 100

  constructor: (options) ->
    @scene = options.scene
    @geometry = new THREE.BoxGeometry(Item.WIDTH, Item.HEIGHT, Item.WIDTH)
    @texture = THREE.ImageUtils.loadTexture('textures/crate.gif')
    @texture.anisotropy = 4
    @material = new THREE.MeshBasicMaterial(map: @texture)
    @mesh = new THREE.Mesh(@geometry, @material)
    @mesh.position = options.position

    @scene.add @mesh