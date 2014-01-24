FS.controller "TeamListViewController", [
  "$scope"
  "BeerpongRosterModel"
  "CalvinballRosterModel"
  "sportsEnum"
  (
    $scope
    BeerpongRosterModel
    CalvinballRosterModel
    sportsEnum
  ) ->

    #---------------------------------------------------------------------------
    # Sport enums.
    #---------------------------------------------------------------------------

    $scope.CALVINBALL = sportsEnum.values.CALVINBALL
    $scope.BEERPONG   = sportsEnum.values.BEERPONG

    #---------------------------------------------------------------------------
    # Sport/roster navigation.
    #---------------------------------------------------------------------------

    $scope.sports       = sportsEnum.values
    $scope.sportNames   = sportsEnum.humanizedValues
    $scope.currentSport = sportsEnum.values.BEERPONG

    $scope.showSport = (sport) ->

      deselectPlayers getSelectedPlayers()

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

    $scope.retireSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.retire player

    $scope.unretireSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.unretire player

    $scope.switchHandednessForSelectedPlayers = ->

      for player in getSelectedPlayers()
        $scope.currentRosterModel.switchHandedness player

    getSelectedPlayers = ->

      return _.where $scope.currentRosterModel.list,
        selected: true

    deselectPlayers = (players) ->

      for player in players
        player.selected = false


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