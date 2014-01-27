window.FS = angular.module "FS", ["ngAnimate", "ngRoute", "angular-table"], [
  "$locationProvider"
  "$routeProvider"
  (
    $locationProvider
    $routeProvider
  ) ->

    $routeProvider.

      when "/team-list",
        templateUrl: "view/team-list/team-list-view.html"
        controller:  "TeamListViewController"
        
      .otherwise
        redirectTo: "/team-list"
]
