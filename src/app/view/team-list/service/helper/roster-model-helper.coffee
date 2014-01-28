FS.factory "rosterModelHelper", [
  (
  ) ->

    return helper =

      removeSelectedPlayers: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.remove player

      activateSelectedPlayers: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.activate player

      deactivateSelectedPlayers: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.deactivate player
        
      switchHandednessForSelectedPlayers: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.switchHandedness player
]