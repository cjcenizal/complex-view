FS.factory "enumFactory", ->

  (config) ->

    enums =
      config:         config
      value:          {}
      humanizedValue: {}

    for enumKey, enumValues of config
      enums.value[enumKey]          = enumValues.value
      enums.humanizedValue[enumKey] = enumValues.humanizedValue

    return enums
