module.exports = class Item
  @HEIGHT: 20
  @WIDTH: 100

  constructor: (@scene, position) ->
    @geometry = new THREE.BoxGeometry(Item.WIDTH, Item.HEIGHT, Item.WIDTH)
    @texture = THREE.ImageUtils.loadTexture('textures/crate.gif')
    @texture.anisotropy = 4
    @material = new THREE.MeshBasicMaterial(map: @texture)
    @mesh = new THREE.Mesh(@geometry, @material)
    @mesh.position = position

    @scene.add @mesh
