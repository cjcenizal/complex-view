FS.directive "fsBeerpongEditor", [
  (
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-table/beerpong-table/beerpong-editor/beerpong-editor.html"
    replace:     true
    scope:
      getSelectedPlayers: "&fsBeerpongEditorGetSelectedPlayers"
      toggleSelectPlayer: "&fsBeerpongEditorToggleSelectPlayer"

    link: (scope) ->

      scope.deselectAllPlayers = ->

        for player in scope.getSelectedPlayers()
          scope.toggleSelectPlayer {player: player}

]