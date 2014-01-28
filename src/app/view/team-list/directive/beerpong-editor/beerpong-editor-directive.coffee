###

fsBeerpongEditor is an example of how you can continue to nest view directives
as you add functionality and need to maintain separation of concerns.

###

FS.directive "fsBeerpongEditor", [
  "showToastSignal"
  "teamListDeselectPlayersSignal"
  (
    showToastSignal
    teamListDeselectPlayersSignal
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/beerpong-editor/beerpong-editor.html"
    replace:     true
    scope:
      currentRosterModel = "fsBeerpongEditorCurrentRosterModel"

    link: (scope) ->

      scope.deselectAllPlayers = ->

        teamListDeselectPlayersSignal.dispatch scope.currentRosterModel?.getSelected()

      scope.showRandomToast = ->

        messages = [
          "All your base belong to us!"
          "It's a trap!"
          "We're losing the forward shields!"
          "Doesn't anyone have any missiles left?!"
          "You require more vespene gas!"
          "Lay down suppressing fire and fall back by twos!"
        ]

        showToastSignal.dispatch _.sample messages

]