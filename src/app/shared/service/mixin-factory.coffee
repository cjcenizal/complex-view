FS.factory "mixinFactory", ->

  (BaseReference, interfaceInstance) ->

    _.defaults BaseReference.prototype, interfaceInstance