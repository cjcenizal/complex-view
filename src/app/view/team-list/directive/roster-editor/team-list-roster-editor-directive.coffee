FS.directive "fsTeamListRosterEditor", [
  "sportEnum"
  (
    sportEnum
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/roster-editor/team-list-roster-editor.html"
    replace:     true
    scope:
      currentSport:       "=fsTeamListRosterEditorCurrentSport"
      currentRosterModel: "=fsTeamListRosterEditorCurrentRosterModel"
      getSelectedPlayers: "=fsTeamListRosterEditorGetSelectedPlayers"

    link: (scope) ->

      #---------------------------------------------------------------------------
      # Sport enums.
      #---------------------------------------------------------------------------

      scope.CALVINBALL = sportEnum.values.CALVINBALL
      scope.BEERPONG   = sportEnum.values.BEERPONG

      #---------------------------------------------------------------------------
      # Common roster actions.
      #---------------------------------------------------------------------------

      scope.addPlayer = ->

        scope.currentRosterModel.add()

      scope.removeSelectedPlayers = ->

        for player in scope.getSelectedPlayers()
          scope.currentRosterModel.remove player

      scope.activateSelectedPlayers = ->

        for player in scope.getSelectedPlayers()
          scope.currentRosterModel.activate player

      scope.deactivateSelectedPlayers = ->

        for player in scope.getSelectedPlayers()
          scope.currentRosterModel.deactivate player

      #---------------------------------------------------------------------------
      # Sport-specific roster actions.
      #---------------------------------------------------------------------------

      scope.switchHandednessForSelectedPlayers = ->

        for player in scope.getSelectedPlayers()
          scope.currentRosterModel.switchHandedness player
]