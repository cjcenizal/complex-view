FS.controller "ToastListController", [
  "$scope"
  "$timeout"
  "showToastSignal"
  (
    $scope
    $timeout
    showToastSignal
  ) ->

    #---------------------------------------------------------------------------
    # Adding toasts.
    #---------------------------------------------------------------------------

    $scope.toasts = []

    showToastSignal.add (message) ->

      $scope.toasts.push
        message: message

      startCleanupTimer()

    #---------------------------------------------------------------------------
    # Removing toasts.
    #---------------------------------------------------------------------------

    SECONDS_TO_READ_TOAST = 3

    cleanupTimeoutPromise = null

    startCleanupTimer = ->

      $timeout.cancel cleanupTimeoutPromise
      cleanupTimeoutPromise = $timeout ->

        removeOldestToast()
        if $scope.toasts.length > 0
          startCleanupTimer()

      , SECONDS_TO_READ_TOAST * 1000

    removeOldestToast = ->

      $scope.toasts.shift()

]