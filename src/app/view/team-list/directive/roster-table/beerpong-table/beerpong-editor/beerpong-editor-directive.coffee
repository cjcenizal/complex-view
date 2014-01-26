FS.directive "fsBeerpongEditor", [
  "teamListDeselectPlayersSignal"
  (
    teamListDeselectPlayersSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table/beerpong-table/beerpong-editor/beerpong-editor.html"
    replace:     true
    scope:
      currentRosterModel = "fsBeerpongEditorCurrentRosterModel"

    link: (scope) ->

      scope.deselectAllPlayers = ->

        teamListDeselectPlayersSignal.dispatch scope.currentRosterModel?.getSelected()

]