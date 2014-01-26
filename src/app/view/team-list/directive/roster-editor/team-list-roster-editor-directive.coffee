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

    link: (scope) ->

      #-------------------------------------------------------------------------
      # Sport enums.
      #-------------------------------------------------------------------------

      scope.CALVINBALL = sportEnum.value.CALVINBALL
      scope.BEERPONG   = sportEnum.value.BEERPONG

      #-------------------------------------------------------------------------
      # Common roster actions.
      #-------------------------------------------------------------------------

      scope.addPlayer = ->

        scope.currentRosterModel.add()

      scope.removeSelectedPlayers = ->

        for player in scope.currentRosterModel.getSelected()
          scope.currentRosterModel.remove player

      scope.activateSelectedPlayers = ->

        for player in scope.currentRosterModel.getSelected()
          scope.currentRosterModel.activate player

      scope.deactivateSelectedPlayers = ->

        for player in scope.currentRosterModel.getSelected()
          scope.currentRosterModel.deactivate player

      #-------------------------------------------------------------------------
      # Sport-specific roster actions.
      #-------------------------------------------------------------------------

      scope.switchHandednessForSelectedPlayers = ->

        for player in scope.currentRosterModel.getSelected()
          scope.currentRosterModel.switchHandedness player
]