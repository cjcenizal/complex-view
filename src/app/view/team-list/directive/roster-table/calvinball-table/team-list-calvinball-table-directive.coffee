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

      # TODO: Add button that shows random "toasty"-style Calvinball image

      ###
      This directive requires creates its own `toggleSelectPlayer` scope method,
      which uses a signal to communicate with whatever directive is listening.
      ###

      scope.toggleSelectPlayer = (player) ->

        teamListToggleSelectPlayerSignal.dispatch player

]