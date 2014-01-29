###

fsTeamListRosterTableContainer contains logic shared across all tables which, in this
case, is just row-selection logic.

###

FS.directive "fsTeamListRosterTableContainer", [
  "teamListDeselectPlayersSignal"
  "teamListToggleSelectPlayerSignal"
  (
    teamListDeselectPlayersSignal
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table-container/team-list-roster-table-container.html"
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

      toggleSelectPlayer = (player) ->

        scope.currentRosterModel.toggleSelect player

      removeToggleSelectPlayerListener =
        teamListToggleSelectPlayerSignal.add toggleSelectPlayer

      removeDeselectPlayersListener =
        teamListDeselectPlayersSignal.add deselectPlayers

      #-------------------------------------------------------------------------
      # Clean up.
      #-------------------------------------------------------------------------

      scope.$on "$destroy", ->

        removeToggleSelectPlayerListener()
        removeDeselectPlayersListener()

]