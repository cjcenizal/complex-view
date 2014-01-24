FS.directive "fsTeamListRosterTable", ->

  restrict:    "E"
  templateUrl: "view/team-list/directive/roster-table/team-list-roster-table.html"
  replace:     true
  scope:
    currentSport:       "=fsTeamListRosterTableCurrentSport"
    currentRosterModel: "=fsTeamListRosterTableCurrentRosterModel"

  link: (scope) ->

    #---------------------------------------------------------------------------
    # Row selection.
    #---------------------------------------------------------------------------

    scope.toggleSelectPlayer = (player) ->
      
      player.selected = not player.selected
