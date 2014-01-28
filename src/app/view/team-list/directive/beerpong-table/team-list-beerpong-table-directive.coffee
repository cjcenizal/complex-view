###

fsTeamListBeerpongTable contains beerpong-specific logic. Creating directives
like this and fsTeamListCalvinballTable appears to duplicate code, but this is
a better choice than the alternative. Duplicating code that happens to look
similar lets us clearly separate concerns and paves the way for future growth
of the codebase. Combining the two directives would be an artificial joining of
the concerns, and create a maintanence nightmare.

###

FS.directive "fsTeamListBeerpongTable", [
  "teamListToggleSelectPlayerSignal"
  (
    teamListToggleSelectPlayerSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/beerpong-table/team-list-beerpong-table.html"
    replace:     true
    scope:
      currentRosterModel: "=fsTeamListBeerpongTableCurrentRosterModel"

    link: (scope) ->

      scope.toggleSelectPlayer = (player) ->

        teamListToggleSelectPlayerSignal.dispatch player


]