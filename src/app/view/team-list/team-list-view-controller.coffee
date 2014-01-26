FS.controller "TeamListViewController", [
  "$scope"
  "BeerpongRosterModel"
  "CalvinballRosterModel"
  "sportEnum"
  "teamListDeselectPlayersSignal"
  (
    $scope
    BeerpongRosterModel
    CalvinballRosterModel
    sportEnum
    teamListDeselectPlayersSignal
  ) ->

    #---------------------------------------------------------------------------
    # Models.
    #---------------------------------------------------------------------------

    $scope.rosterModels = {}

    # TODO: Normally we'd authenticate + load from the back-end, but for now
    # voila, we have our user's rosters.

    $scope.rosterModels[sportEnum.values.CALVINBALL] = new CalvinballRosterModel()
    $scope.rosterModels[sportEnum.values.BEERPONG]   = new BeerpongRosterModel()

    $scope.$watch "currentSport", (currentSport, previousCurrentSport) ->

      if currentSport isnt previousCurrentSport
        # Deselect current players and switch roster.
        teamListDeselectPlayersSignal.dispatch $scope.currentRosterModel?.getSelected()
        $scope.currentRosterModel = $scope.rosterModels[$scope.currentSport]

    #---------------------------------------------------------------------------
    # View state.
    #---------------------------------------------------------------------------

    $scope.currentSport       = sportEnum.values.CALVINBALL
    $scope.currentRosterModel = $scope.rosterModels[$scope.currentSport]

]