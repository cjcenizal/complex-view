FS.directive "fsTeamListBeerpongTable", [
  (
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/beerpong-table/team-list-beerpong-table.html"
    replace:     true
    scope:
      currentRosterModel: "=fsTeamListBeerpongTableCurrentRosterModel"
      toggleSelectPlayer: "&fsTeamListBeerpongTableToggleSelectPlayer"

    link: (scope) ->

      # TODO: Add button for showing a toast "Drink!"

      ###
      This directive requires `toggleSelectPlayer` to be provided via its
      attributes.  This means it needs to be called in a special way from the
      template.  It also gets tricky if you want to provide it to a child
      directive with an isolated scope.
      ###

]