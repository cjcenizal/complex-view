FS.directive "fsTeamListSportNavigation", [
  "sportEnum"
  (
    sportEnum
  ) ->

    restrict:    "E"
    templateUrl: "view/team-list/directive/sport-navigation/team-list-sport-navigation.html"
    replace:     true
    scope:
      currentSport: "=fsTeamListSportNavigationCurrentSport"

    link: (scope) ->

      scope.sports       = sportEnum.values
      scope.sportNames   = sportEnum.humanizedValues

      # Set default sport.
      # TODO: Pass this in via attribute so view controller can be in charge.
      scope.currentSport = sportEnum.values.CALVINBALL

      scope.showSport = (sport) ->

        scope.currentSport = sport
]