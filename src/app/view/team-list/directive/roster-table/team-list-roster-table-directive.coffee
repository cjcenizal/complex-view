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
      getSelectedPlayers: "&fsTeamListRosterTableGetSelectedPlayers"

    link: (scope) ->

      #---------------------------------------------------------------------------
      # Selecting players.
      #---------------------------------------------------------------------------

      deselectPlayers = (players) ->

        for player in players
          player.selected = false

      scope.toggleSelectPlayer = (player) ->

        player.selected = not player.selected

      removeToggleSelectPlayerListener =
        teamListToggleSelectPlayerSignal.add scope.toggleSelectPlayer

      removeDeselectPlayersListener =
        teamListDeselectPlayersSignal.add deselectPlayers

      #---------------------------------------------------------------------------
      # Clean up.
      #---------------------------------------------------------------------------

      scope.$on "$destroy", ->

        removeToggleSelectPlayerListener()
        removeDeselectPlayersListener()

]