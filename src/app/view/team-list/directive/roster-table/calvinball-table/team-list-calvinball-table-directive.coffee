FS.directive "fsTeamListCalvinballTable", [
  "teamListToggleSelectPlayerSignal"
  (
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table/calvinball-table/team-list-calvinball-table.html"
    replace:     true
    scope:
      currentRosterModel: "=fsTeamListCalvinballTableCurrentRosterModel"

    link: (scope) ->

      # Add button that shows random "toasty"-style Calvinball image

      scope.toggleSelectPlayer = (player) ->

        teamListToggleSelectPlayerSignal.dispatch player

]