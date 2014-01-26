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
    # Current sport.
    #---------------------------------------------------------------------------

    $scope.currentSport = null

    #---------------------------------------------------------------------------
    # Selected players.
    #---------------------------------------------------------------------------

    $scope.getSelectedPlayers = ->

      return _.where $scope.currentRosterModel?.list,
        selected: true

    #---------------------------------------------------------------------------
    # User's rosters.
    #---------------------------------------------------------------------------

    $scope.rosterModels = {}

    # TODO: Normally we'd authenticate + load from the back-end, but for now
    # voila, we have our user's rosters.

    $scope.rosterModels[sportEnum.values.CALVINBALL] = new CalvinballRosterModel()
    $scope.rosterModels[sportEnum.values.BEERPONG]   = new BeerpongRosterModel()

    $scope.$watch "currentSport", (currentSport, previousCurrentSport) ->

      if currentSport isnt previousCurrentSport
        # Deselect current players and switch section.
        teamListDeselectPlayersSignal.dispatch $scope.getSelectedPlayers()
        $scope.currentRosterModel = $scope.rosterModels[$scope.currentSport]

]