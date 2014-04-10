Stack = require './Stack.coffee'

module.exports = class Storehouse

  constructor: (options) ->
    @maxItems = options.maxItems
    @stacks = []
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize(window.innerWidth, window.innerHeight)
    document.body.appendChild(@renderer.domElement)

    @camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 1, 1000)
    @camera.position.z = 400

    @controls = new THREE.FirstPersonControls @camera
    @controls.movementSpeed = 200;
    @controls.lookSpeed = .25

    @scene = new THREE.Scene()
    @clock = new THREE.Clock()

    @initStacks(options.items)

    window.addEventListener('resize', (=> @resize()), false)
    @resize()
    @render()

  resize: ->
    @camera.aspect = window.innerWidth / window.innerHeight
    @camera.updateProjectionMatrix()
    @renderer.setSize(window.innerWidth, window.innerHeight)
    @controls.handleResize();

  render: ->
    requestAnimationFrame(=> @render())
    @renderer.render(@scene, @camera)
    @controls.update @clock.getDelta()

  initStacks: (initialItems) ->
    @size = Math.ceil Math.sqrt initialItems.length
    for numberOfItems in initialItems
      @addStack numberOfItems

  addStack: (numberOfItems = 0) ->
    stackCounter = @stacks.length
    pos =
      x: Math.floor(stackCounter / @size)*120
      y: 0
      z: Math.floor(stackCounter % @size)*120
    @stacks.push new Stack
      scene: @scene
      position: pos
      maxItems: @maxItems
    i = 0
    while i++ < numberOfItems
      @addItem stackCounter

  addItem: (stackId) ->
    @stacks[stackId].addItem()

  relocate: (originStackId, targetStackId) ->
    @stacks[originStackId].relocateTo @stacks[targetStackId]

  unload: (stackId) ->
    @stacks[stackId].unload()
