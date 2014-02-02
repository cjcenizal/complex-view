###

fsTeamListRosterEditor provides an API for interacting with the
currentRosterModel.

###

FS.directive "fsTeamListRosterEditor", [
  "rosterModelSelectedPlayersHelper"
  "sportEnum"
  (
    rosterModelSelectedPlayersHelper
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

        rosterModelSelectedPlayersHelper.remove scope.currentRosterModel

      scope.activateSelectedPlayers = ->

        rosterModelSelectedPlayersHelper.activate scope.currentRosterModel

      scope.deactivateSelectedPlayers = ->

        rosterModelSelectedPlayersHelper.deactivate scope.currentRosterModel

      #-------------------------------------------------------------------------
      # Sport-specific roster actions.
      #-------------------------------------------------------------------------

      scope.switchHandednessForSelectedPlayers = ->

        rosterModelSelectedPlayersHelper.switchHandedness scope.currentRosterModel
        
]