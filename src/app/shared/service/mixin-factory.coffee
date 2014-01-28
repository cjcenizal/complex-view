FS.factory "mixinFactory", ->

  (MixIntoClassReference, mixinInterface, shouldOverrideProperties = false) ->

    if shouldOverrideProperties
      _.extends MixIntoClassReference.prototype, mixinInterface

    else
      _.defaults MixIntoClassReference.prototype, mixinInterface