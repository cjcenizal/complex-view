FS.factory "mixinFactory", ->

  (MixIntoClassReference, mixinInterface) ->

    _.defaults MixIntoClassReference.prototype, mixinInterface