###

fsTeamListRosterEditor provides an API for interacting with the
currentRosterModel.

###

FS.directive "fsTeamListRosterEditor", [
  "rosterModelHelper"
  "sportEnum"
  (
    rosterModelHelper
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

      scope.BEERPONG   = sportEnum.value.BEERPONG

      #-------------------------------------------------------------------------
      # Common roster actions.
      #-------------------------------------------------------------------------

      scope.addPlayer = ->

        scope.currentRosterModel.add()

      scope.removeSelectedPlayers = ->

        rosterModelHelper.removeSelectedPlayers scope.currentRosterModel

      scope.activateSelectedPlayers = ->

        rosterModelHelper.activateSelectedPlayers scope.currentRosterModel

      scope.deactivateSelectedPlayers = ->

        rosterModelHelper.deactivateSelectedPlayers scope.currentRosterModel

      #-------------------------------------------------------------------------
      # Sport-specific roster actions.
      #-------------------------------------------------------------------------

      scope.switchHandednessForSelectedPlayers = ->

        rosterModelHelper.switchHandednessForSelectedPlayers scope.currentRosterModel
        
]