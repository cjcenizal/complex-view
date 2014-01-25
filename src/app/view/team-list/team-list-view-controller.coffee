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
    # Sport enums.
    #---------------------------------------------------------------------------

    $scope.CALVINBALL = sportEnum.values.CALVINBALL
    $scope.BEERPONG   = sportEnum.values.BEERPONG

    #---------------------------------------------------------------------------
    # Sport/roster navigation.
    #---------------------------------------------------------------------------

    $scope.sports       = sportEnum.values
    $scope.sportNames   = sportEnum.humanizedValues
    $scope.currentSport = sportEnum.values.BEERPONG

    $scope.showSport = (sport) ->

      teamListDeselectPlayersSignal.dispatch getSelectedPlayers()

      $scope.currentSport       = sport
      $scope.currentRosterModel = getCurrentRostetModel()

    #---------------------------------------------------------------------------
    # Common table actions.
    #---------------------------------------------------------------------------

    $scope.addPlayer = ->

      $scope.currentRosterModel.add()

    $scope.removeSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.remove player

    $scope.activateSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.activate player

    $scope.deactivateSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.deactivate player

    $scope.switchHandednessForSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.switchHandedness player

    #---------------------------------------------------------------------------
    # Selected players.
    #---------------------------------------------------------------------------

    getSelectedPlayers = ->

      return _.where $scope.currentRosterModel.list,
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

    $scope.currentRosterModel = getCurrentRostetModel()

]