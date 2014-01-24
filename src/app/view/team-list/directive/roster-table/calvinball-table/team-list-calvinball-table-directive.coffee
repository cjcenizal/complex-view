FS.directive "fsTeamListCalvinballTable", ->

  restrict:    "E"
  templateUrl: "view/team-list/directive/roster-table/calvinball-table/team-list-calvinball-table.html"
  replace:     true
  scope:
    currentRosterModel: "=fsTeamListCalvinballTableCurrentRosterModel"
    toggleSelectPlayer: "&fsTeamListCalvinballTableToggleSelectPlayer"

  link: (scope) ->

    # Add button that shows random "toasty"-style Calvinball image
