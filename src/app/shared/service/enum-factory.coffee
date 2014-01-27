FS.factory "enumFactory", ->

  (config) ->

    enums =
      config:         config
      value:          {}
      humanizedValue: {}

    for enumKey, enumValues of config

      # Ensure values cannot be changed.
      Object.defineProperty enums.value, enumKey,
        enumerable: true
        value:      enumValues.value

      # Ensure humanized values cannot be changed.
      Object.defineProperty enums.humanizedValue, enumKey,
        enumerable: true
        value:      enumValues.humanizedValue

    return enums
