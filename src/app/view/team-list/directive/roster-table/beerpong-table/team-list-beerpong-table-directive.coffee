FS.directive "fsTeamListBeerpongTable", ->

  restrict:    "E"
  templateUrl: "view/team-list/directive/roster-table/beerpong-table/team-list-beerpong-table.html"
  replace:     true
  scope:
    currentRosterModel: "=fsTeamListBeerpongTableCurrentRosterModel"
    toggleSelectPlayer: "&fsTeamListBeerpongTableToggleSelectPlayer"

  link: (scope) ->

    # Add button for showing a toast "Drink!"
