FS.factory "rosterModelSelectedPlayersHelper", [
  (
  ) ->

    return helper =

      remove: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.remove player

      activate: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.activate player

      deactivate: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.deactivate player
        
      switchHandedness: (rosterModel) ->

        for player in rosterModel.getSelected()
          rosterModel.switchHandedness player
]