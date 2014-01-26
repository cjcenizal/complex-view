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
    # Sport enums.
    #---------------------------------------------------------------------------

    $scope.CALVINBALL = sportEnum.values.CALVINBALL
    $scope.BEERPONG   = sportEnum.values.BEERPONG

    #---------------------------------------------------------------------------
    # Common table actions.
    #---------------------------------------------------------------------------

    $scope.addPlayer = ->

      $scope.currentRosterModel.add()

    $scope.removeSelectedPlayers = ->

      for player in $scope.getSelectedPlayers()
        $scope.currentRosterModel.remove player

    $scope.activateSelectedPlayers = ->

      for player in $scope.getSelectedPlayers()
        $scope.currentRosterModel.activate player

    $scope.deactivateSelectedPlayers = ->

      for player in $scope.getSelectedPlayers()
        $scope.currentRosterModel.deactivate player

    $scope.switchHandednessForSelectedPlayers = ->

      for player in $scope.getSelectedPlayers()
        $scope.currentRosterModel.switchHandedness player

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

    $scope.rosterModels[$scope.CALVINBALL] = new CalvinballRosterModel()
    $scope.rosterModels[$scope.BEERPONG]   = new BeerpongRosterModel()

    getCurrentRostetModel = ->

      return $scope.rosterModels[$scope.currentSport]

    $scope.$watch "currentSport", (currentSport, previousCurrentSport) ->

      if currentSport isnt previousCurrentSport
        # Deselect current players and switch section.
        teamListDeselectPlayersSignal.dispatch $scope.getSelectedPlayers()
        $scope.currentRosterModel = getCurrentRostetModel()

]