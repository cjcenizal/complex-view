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

      scope.sports     = sportEnum.value
      scope.sportNames = sportEnum.humanizedValue

      scope.showSport = (sport) ->

        scope.currentSport = sport
]