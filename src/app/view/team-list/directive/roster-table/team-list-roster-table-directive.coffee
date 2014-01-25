FS.directive "fsTeamListRosterTable", ->

  restrict:    "E"
  templateUrl: "view/team-list/directive/roster-table/team-list-roster-table.html"
  replace:     true
  scope:
    currentSport:       "=fsTeamListRosterTableCurrentSport"
    currentRosterModel: "=fsTeamListRosterTableCurrentRosterModel"

  link: (scope) ->

    # Image some additional functionality needs to exist in this view, such as um...
