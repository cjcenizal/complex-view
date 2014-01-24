FS.factory "mixinFactory", ->

  (BaseReference, interfaceInstance) ->

    _.extend BaseReference.prototype, interfaceInstance