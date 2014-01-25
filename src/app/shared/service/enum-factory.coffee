FS.factory "enumFactory", ->

  (config) ->

    enums =
      values:          {}
      humanizedValues: {}

    for enumKey, enumValues of config
      enums.values[enumKey]          = enumValues.value
      enums.humanizedValues[enumKey] = enumValues.humanizedValue

    return enums
