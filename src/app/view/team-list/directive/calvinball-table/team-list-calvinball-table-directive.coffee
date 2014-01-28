###

fsTeamListCalvinballTable contains calvinball-specific logic. Creating
directives like this and fsTeamListBeerpongTable appears to duplicate code,
but this is a better choice than the alternative. Duplicating code that happens
to look similar lets us clearly separate concerns and paves the way for future
growth of the codebase. Combining the two directives would be an artificial
joining of the concerns, and create a maintanence nightmare.

###

FS.directive "fsTeamListCalvinballTable", [
  "teamListToggleSelectPlayerSignal"
  (
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/calvinball-table/team-list-calvinball-table.html"
    replace:     true
    scope:
      currentRosterModel: "=fsTeamListCalvinballTableCurrentRosterModel"

    link: (scope) ->

      scope.toggleSelectPlayer = (player) ->

        teamListToggleSelectPlayerSignal.dispatch player

]