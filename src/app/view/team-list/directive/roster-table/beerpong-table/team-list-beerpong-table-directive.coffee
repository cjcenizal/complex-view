FS.directive "fsTeamListBeerpongTable", [
  "teamListToggleSelectPlayerSignal"
  (
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table/beerpong-table/team-list-beerpong-table.html"
    replace:     true
    scope:
      currentRosterModel: "=fsTeamListBeerpongTableCurrentRosterModel"

    link: (scope) ->

      # Add button for showing a toast "Drink!"

      scope.toggleSelectPlayer = (player) ->

        teamListToggleSelectPlayerSignal.dispatch player
]