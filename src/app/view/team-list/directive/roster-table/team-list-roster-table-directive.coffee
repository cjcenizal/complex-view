FS.directive "fsTeamListRosterTable", [
  "teamListDeselectPlayersSignal"
  "teamListToggleSelectPlayerSignal"
  (
    teamListDeselectPlayersSignal
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table/team-list-roster-table.html"
    replace:     true
    scope:
      currentSport:       "=fsTeamListRosterTableCurrentSport"
      currentRosterModel: "=fsTeamListRosterTableCurrentRosterModel"

    link: (scope) ->

      #-------------------------------------------------------------------------
      # Selecting players.
      #-------------------------------------------------------------------------

      deselectPlayers = (players) ->

        scope.currentRosterModel?.deselectAll()

      scope.toggleSelectPlayer = (player) ->

        scope.currentRosterModel.toggleSelect player

      removeToggleSelectPlayerListener =
        teamListToggleSelectPlayerSignal.add scope.toggleSelectPlayer

      removeDeselectPlayersListener =
        teamListDeselectPlayersSignal.add deselectPlayers

      #-------------------------------------------------------------------------
      # Clean up.
      #-------------------------------------------------------------------------

      scope.$on "$destroy", ->

        removeToggleSelectPlayerListener()
        removeDeselectPlayersListener()

]