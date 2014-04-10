module.exports = class Item
  @HEIGHT: 20
  @WIDTH: 100

  constructor: (options) ->
    @scene = options.scene
    @geometry = new THREE.BoxGeometry(Item.WIDTH, Item.HEIGHT-2, Item.WIDTH)
    @texture = THREE.ImageUtils.loadTexture('textures/crate.gif')
    @texture.anisotropy = 4
    @material = new THREE.MeshBasicMaterial(map: @texture)
    @mesh = new THREE.Mesh(@geometry, @material)
    @mesh.position = options.position

    @scene.add @mesh
