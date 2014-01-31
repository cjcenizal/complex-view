(function() {
  window.FS = angular.module("FS", ["ngAnimate", "ngRoute", "angular-table"], [
    "$locationProvider", "$routeProvider", function($locationProvider, $routeProvider) {
      return $routeProvider.when("/team-list", {
        templateUrl: "view/team-list/team-list-view.html",
        controller: "TeamListViewController"
      }).otherwise({
        redirectTo: "/team-list"
      });
    }
  ]);

}).call(this);

(function() {
  FS.factory("showToastSignal", [
    "signalFactory", function(signalFactory) {
      return signalFactory.create();
    }
  ]);

}).call(this);

(function() {
  FS.controller("ToastListController", [
    "$animate", "$scope", "$timeout", "showToastSignal", function($animate, $scope, $timeout, showToastSignal) {
      var SECONDS_TO_READ_TOAST, cleanupTimeoutPromise, removeOldestToast, startCleanupTimer;
      $scope.toasts = [];
      showToastSignal.add(function(message) {
        $scope.toasts.push({
          message: message
        });
        return startCleanupTimer();
      });
      SECONDS_TO_READ_TOAST = 3;
      cleanupTimeoutPromise = null;
      startCleanupTimer = function() {
        $timeout.cancel(cleanupTimeoutPromise);
        return cleanupTimeoutPromise = $timeout(function() {
          removeOldestToast();
          if ($scope.toasts.length > 0) {
            return startCleanupTimer();
          }
        }, SECONDS_TO_READ_TOAST * 1000);
      };
      removeOldestToast = function() {
        return $scope.toasts.shift();
      };
      return $scope.removeToastAt = function(index) {
        $scope.toasts.splice(index, 1);
        return startCleanupTimer();
      };
    }
  ]);

}).call(this);

(function() {
  FS.factory("enumFactory", function() {
    return function(config) {
      var enumKey, enumValues, enums;
      enums = {
        config: config,
        value: {},
        humanizedValue: {}
      };
      for (enumKey in config) {
        enumValues = config[enumKey];
        Object.defineProperty(enums.value, enumKey, {
          enumerable: true,
          value: enumValues.value
        });
        Object.defineProperty(enums.humanizedValue, enumKey, {
          enumerable: true,
          value: enumValues.humanizedValue
        });
      }
      return enums;
    };
  });

}).call(this);

(function() {
  FS.factory("mixinFactory", function() {
    return function(MixIntoClassReference, mixinInterface, shouldOverrideProperties) {
      if (shouldOverrideProperties == null) {
        shouldOverrideProperties = false;
      }
      if (shouldOverrideProperties) {
        return _["extends"](MixIntoClassReference.prototype, mixinInterface);
      } else {
        return _.defaults(MixIntoClassReference.prototype, mixinInterface);
      }
    };
  });

}).call(this);

(function() {
  FS.factory("signalFactory", function() {
    var Signal;
    Signal = (function() {
      function _Class() {
        this._listeners = [];
      }

      _Class.prototype.add = function(listener) {
        var removeCallback,
          _this = this;
        removeCallback = function() {
          return _this.remove(listener);
        };
        if (this.has(listener)) {
          return removeCallback;
        }
        this._listeners.push(listener);
        return removeCallback;
      };

      _Class.prototype.has = function(listener) {
        if (this._listeners.indexOf(listener) >= 0) {
          return true;
        }
        return false;
      };

      _Class.prototype.remove = function(listener) {
        if (!this.has(listener)) {
          return;
        }
        return this._listeners.splice(this._listeners.indexOf(listener), 1);
      };

      _Class.prototype.removeAll = function() {
        return this._listeners = [];
      };

      _Class.prototype.dispatch = function() {
        var listener, _i, _len, _ref, _results;
        _ref = this._listeners;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          listener = _ref[_i];
          _results.push(listener.apply(null, arguments));
        }
        return _results;
      };

      return _Class;

    })();
    return {
      create: function() {
        return new Signal;
      }
    };
  });

}).call(this);

/*

fsBeerpongEditor is an example of how you can continue to nest view directives
as you add functionality and need to maintain separation of concerns.
*/


(function() {
  FS.directive("fsBeerpongEditor", [
    "showToastSignal", "teamListDeselectPlayersSignal", function(showToastSignal, teamListDeselectPlayersSignal) {
      var currentRosterModel;
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/beerpong-editor/beerpong-editor.html",
        replace: true,
        scope: currentRosterModel = "fsBeerpongEditorCurrentRosterModel",
        link: function(scope) {
          scope.deselectAllPlayers = function() {
            var _ref;
            return teamListDeselectPlayersSignal.dispatch((_ref = scope.currentRosterModel) != null ? _ref.getSelected() : void 0);
          };
          return scope.showRandomToast = function() {
            var messages;
            messages = ["All your base belong to us!", "It's a trap!", "We're losing the forward shields!", "Doesn't anyone have any missiles left?!", "You require more vespene gas!", "Lay down suppressing fire and fall back by twos!"];
            return showToastSignal.dispatch(_.sample(messages));
          };
        }
      };
    }
  ]);

}).call(this);

/*

fsTeamListBeerpongTable contains beerpong-specific logic. Creating directives
like this and fsTeamListCalvinballTable appears to duplicate code, but this is
a better choice than the alternative. Duplicating code that happens to look
similar lets us clearly separate concerns and paves the way for future growth
of the codebase. Combining the two directives would be an artificial joining of
the concerns, and create a maintanence nightmare.
*/


(function() {
  FS.directive("fsTeamListBeerpongTable", [
    "teamListToggleSelectPlayerSignal", function(teamListToggleSelectPlayerSignal) {
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/beerpong-table/team-list-beerpong-table.html",
        replace: true,
        scope: {
          currentRosterModel: "=fsTeamListBeerpongTableCurrentRosterModel"
        },
        link: function(scope) {
          return scope.toggleSelectPlayer = function(player) {
            return teamListToggleSelectPlayerSignal.dispatch(player);
          };
        }
      };
    }
  ]);

}).call(this);

/*

fsTeamListCalvinballTable contains calvinball-specific logic. Creating
directives like this and fsTeamListBeerpongTable appears to duplicate code,
but this is a better choice than the alternative. Duplicating code that happens
to look similar lets us clearly separate concerns and paves the way for future
growth of the codebase. Combining the two directives would be an artificial
joining of the concerns, and create a maintanence nightmare.
*/


(function() {
  FS.directive("fsTeamListCalvinballTable", [
    "teamListToggleSelectPlayerSignal", function(teamListToggleSelectPlayerSignal) {
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/calvinball-table/team-list-calvinball-table.html",
        replace: true,
        scope: {
          currentRosterModel: "=fsTeamListCalvinballTableCurrentRosterModel"
        },
        link: function(scope) {
          return scope.toggleSelectPlayer = function(player) {
            return teamListToggleSelectPlayerSignal.dispatch(player);
          };
        }
      };
    }
  ]);

}).call(this);

/*

fsTeamListRosterEditor provides an API for interacting with the
currentRosterModel.
*/


(function() {
  FS.directive("fsTeamListRosterEditor", [
    "rosterModelHelper", "sportEnum", function(rosterModelHelper, sportEnum) {
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/roster-editor/team-list-roster-editor.html",
        replace: true,
        scope: {
          currentSport: "=fsTeamListRosterEditorCurrentSport",
          currentRosterModel: "=fsTeamListRosterEditorCurrentRosterModel"
        },
        link: function(scope) {
          scope.BEERPONG = sportEnum.value.BEERPONG;
          scope.addPlayer = function() {
            return scope.currentRosterModel.add();
          };
          scope.removeSelectedPlayers = function() {
            return rosterModelHelper.removeSelectedPlayers(scope.currentRosterModel);
          };
          scope.activateSelectedPlayers = function() {
            return rosterModelHelper.activateSelectedPlayers(scope.currentRosterModel);
          };
          scope.deactivateSelectedPlayers = function() {
            return rosterModelHelper.deactivateSelectedPlayers(scope.currentRosterModel);
          };
          return scope.switchHandednessForSelectedPlayers = function() {
            return rosterModelHelper.switchHandednessForSelectedPlayers(scope.currentRosterModel);
          };
        }
      };
    }
  ]);

}).call(this);

/*

fsTeamListRosterTableContainer contains logic shared across all tables which, in this
case, is just row-selection logic.
*/


(function() {
  FS.directive("fsTeamListRosterTableContainer", [
    "teamListDeselectPlayersSignal", "teamListToggleSelectPlayerSignal", function(teamListDeselectPlayersSignal, teamListToggleSelectPlayerSignal) {
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/roster-table-container/team-list-roster-table-container.html",
        replace: true,
        scope: {
          currentSport: "=fsTeamListRosterTableCurrentSport",
          currentRosterModel: "=fsTeamListRosterTableCurrentRosterModel"
        },
        link: function(scope) {
          var deselectPlayers, removeDeselectPlayersListener, removeToggleSelectPlayerListener, toggleSelectPlayer;
          deselectPlayers = function(players) {
            var _ref;
            return (_ref = scope.currentRosterModel) != null ? _ref.deselectAll() : void 0;
          };
          toggleSelectPlayer = function(player) {
            return scope.currentRosterModel.toggleSelect(player);
          };
          removeToggleSelectPlayerListener = teamListToggleSelectPlayerSignal.add(toggleSelectPlayer);
          removeDeselectPlayersListener = teamListDeselectPlayersSignal.add(deselectPlayers);
          return scope.$on("$destroy", function() {
            removeToggleSelectPlayerListener();
            return removeDeselectPlayersListener();
          });
        }
      };
    }
  ]);

}).call(this);

/*

fsTeamListSportNavigation changes the currentSport to be displayed.
*/


(function() {
  FS.directive("fsTeamListSportNavigation", [
    "sportEnum", function(sportEnum) {
      return {
        restrict: "E",
        templateUrl: "view/team-list/directive/sport-navigation/team-list-sport-navigation.html",
        replace: true,
        scope: {
          currentSport: "=fsTeamListSportNavigationCurrentSport"
        },
        link: function(scope) {
          scope.sports = sportEnum.value;
          scope.sportNames = sportEnum.humanizedValue;
          return scope.showSport = function(sport) {
            return scope.currentSport = sport;
          };
        }
      };
    }
  ]);

}).call(this);

(function() {
  FS.factory("sportEnum", [
    "enumFactory", function(enumFactory) {
      return enumFactory({
        BEERPONG: {
          value: "BEERPONG",
          humanizedValue: "Beer pong"
        },
        CALVINBALL: {
          value: "CALVINBALL",
          humanizedValue: "Calvinball"
        }
      });
    }
  ]);

}).call(this);

(function() {
  FS.factory("rosterModelHelper", [
    function() {
      var helper;
      return helper = {
        removeSelectedPlayers: function(rosterModel) {
          var player, _i, _len, _ref, _results;
          _ref = rosterModel.getSelected();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            player = _ref[_i];
            _results.push(rosterModel.remove(player));
          }
          return _results;
        },
        activateSelectedPlayers: function(rosterModel) {
          var player, _i, _len, _ref, _results;
          _ref = rosterModel.getSelected();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            player = _ref[_i];
            _results.push(rosterModel.activate(player));
          }
          return _results;
        },
        deactivateSelectedPlayers: function(rosterModel) {
          var player, _i, _len, _ref, _results;
          _ref = rosterModel.getSelected();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            player = _ref[_i];
            _results.push(rosterModel.deactivate(player));
          }
          return _results;
        },
        switchHandednessForSelectedPlayers: function(rosterModel) {
          var player, _i, _len, _ref, _results;
          _ref = rosterModel.getSelected();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            player = _ref[_i];
            _results.push(rosterModel.switchHandedness(player));
          }
          return _results;
        }
      };
    }
  ]);

}).call(this);

(function() {
  FS.factory("rosterMixinFactory", function() {
    var RosterMixin, factory;
    RosterMixin = (function() {
      function _Class() {
        this._id = 1;
        this.list = [];
      }

      _Class.prototype.add = function() {
        return this.list.push(this.create());
      };

      _Class.prototype.addWith = function(attributes) {
        return this.list.push(_.extend(this.create(), attributes));
      };

      _Class.prototype.create = function() {
        return {
          name: "New Player " + (this._id++),
          wins: 0,
          losses: 0,
          active: false
        };
      };

      _Class.prototype.remove = function(player) {
        var index;
        index = this.list.indexOf(player);
        return this.list.splice(index, 1);
      };

      _Class.prototype.activate = function(player) {
        return player.active = true;
      };

      _Class.prototype.deactivate = function(player) {
        return player.active = false;
      };

      _Class.prototype.toggleSelect = function(player) {
        return player.selected = !player.selected;
      };

      _Class.prototype.deselectAll = function() {
        var player, _i, _len, _ref, _results;
        _ref = this.getSelected();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          player = _ref[_i];
          _results.push(player.selected = false);
        }
        return _results;
      };

      _Class.prototype.getSelected = function() {
        return _.where(this.list, {
          selected: true
        });
      };

      return _Class;

    })();
    return factory = {
      create: function() {
        return new RosterMixin;
      }
    };
  });

}).call(this);

(function() {
  FS.factory("BeerpongRosterModel", [
    "mixinFactory", "rosterMixinFactory", function(mixinFactory, rosterMixinFactory) {
      var BeerpongRosterModel;
      BeerpongRosterModel = (function() {
        function _Class() {
          this.list = [
            {
              name: "CJ",
              wins: 3,
              losses: 67,
              active: false,
              hand: "Righty",
              position: "Designated drinker"
            }, {
              name: "Karla",
              wins: 429,
              losses: 106,
              active: false,
              hand: "Righty",
              position: "Overlord"
            }, {
              name: "Cory",
              wins: 34,
              losses: 12,
              active: false,
              hand: "Righty",
              position: "Enforcer"
            }, {
              name: "Christina",
              wins: 12,
              losses: 34,
              active: true,
              hand: "Righty",
              position: "Poor loser"
            }, {
              name: "Greg",
              wins: 9,
              losses: 3,
              active: false,
              hand: "Lefty",
              position: "I'm Ron Burgundy?"
            }
          ];
        }

        _Class.prototype.add = function() {
          return this.addWith({
            hand: "Righty",
            position: "None"
          });
        };

        _Class.prototype.switchHandedness = function(player) {
          if (player.hand === "Lefty") {
            return player.hand = "Righty";
          } else if (player.hand === "Righty") {
            return player.hand = "Lefty";
          }
        };

        return _Class;

      })();
      mixinFactory(BeerpongRosterModel, rosterMixinFactory.create());
      return BeerpongRosterModel;
    }
  ]);

}).call(this);

(function() {
  FS.factory("CalvinballRosterModel", [
    "mixinFactory", "rosterMixinFactory", function(mixinFactory, rosterMixinFactory) {
      var CalvinballRosterModel;
      CalvinballRosterModel = (function() {
        function _Class() {
          this.list = [
            {
              name: "Calvin",
              wins: 4,
              losses: 6,
              active: false,
              rule: "'No song' zone"
            }, {
              name: "Hobbes",
              wins: 5,
              losses: 5,
              active: false,
              rule: "Touch the opposite pole"
            }, {
              name: "Susie",
              wins: 8,
              losses: 0,
              active: true,
              rule: "Pernicious Poem Place"
            }, {
              name: "Moe",
              wins: 0,
              losses: 0,
              active: true,
              rule: "Give before it hurts"
            }
          ];
        }

        _Class.prototype.add = function() {
          return this.addWith({
            rule: "None"
          });
        };

        return _Class;

      })();
      mixinFactory(CalvinballRosterModel, rosterMixinFactory.create());
      return CalvinballRosterModel;
    }
  ]);

}).call(this);

(function() {
  FS.factory("teamListDeselectPlayersSignal", [
    "signalFactory", function(signalFactory) {
      return signalFactory.create();
    }
  ]);

}).call(this);

(function() {
  FS.factory("teamListToggleSelectPlayerSignal", [
    "signalFactory", function(signalFactory) {
      return signalFactory.create();
    }
  ]);

}).call(this);

/*

TeamListViewController connects the navigation, the roster editing controls,
and the roster table. It maintains the state of the currentSport and the
currentRosterModel. In a full-scale app, it would also be responsible for
loading the models and other view-initialization and teardown logic.
*/


(function() {
  FS.controller("TeamListViewController", [
    "$scope", "BeerpongRosterModel", "CalvinballRosterModel", "sportEnum", "teamListDeselectPlayersSignal", function($scope, BeerpongRosterModel, CalvinballRosterModel, sportEnum, teamListDeselectPlayersSignal) {
      $scope.rosterModels = {};
      $scope.rosterModels[sportEnum.value.CALVINBALL] = new CalvinballRosterModel();
      $scope.rosterModels[sportEnum.value.BEERPONG] = new BeerpongRosterModel();
      $scope.$watch("currentSport", function(currentSport, previousCurrentSport) {
        var _ref;
        if (currentSport !== previousCurrentSport) {
          teamListDeselectPlayersSignal.dispatch((_ref = $scope.currentRosterModel) != null ? _ref.getSelected() : void 0);
          return $scope.currentRosterModel = $scope.rosterModels[$scope.currentSport];
        }
      });
      $scope.currentSport = sportEnum.value.CALVINBALL;
      return $scope.currentRosterModel = $scope.rosterModels[$scope.currentSport];
    }
  ]);

}).call(this);

angular.module('FS').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('layout/toast-list/toast-list.html',
    "\n" +
    "<div ng-controller=\"ToastListController\" class=\"toast-list\">\n" +
    "  <div ng-repeat=\"toast in toasts\" ng-click=\"removeToastAt($index)\" class=\"panel toast\">{{toast.message}}</div>\n" +
    "</div>"
  );


  $templateCache.put('view/team-list/directive/beerpong-editor/beerpong-editor.html',
    "\n" +
    "<div><a ng-click=\"deselectAllPlayers()\" class=\"button tiny round\">Deselect all</a><a ng-click=\"showRandomToast()\" class=\"button tiny round\">Show toast</a></div>"
  );


  $templateCache.put('view/team-list/directive/beerpong-table/team-list-beerpong-table.html',
    "\n" +
    "<div>\n" +
    "  <table at-table=\"at-table\" list=\"currentRosterModel.list\">\n" +
    "    <thead>\n" +
    "      <th attribute=\"active\"><i class=\"fa fa-bolt\"></i></th>\n" +
    "    </thead>\n" +
    "    <tbody>\n" +
    "      <tr ng-click=\"toggleSelectPlayer(item)\" ng-class=\"{'selected-row' : item.selected == true}\">\n" +
    "        <td attribute=\"active\">\n" +
    "          <div ng-show=\"item.active == true\"><i class=\"fa fa-check\"></i></div>\n" +
    "          <div ng-show=\"item.active == false\"><i class=\"icon-spacer\"></i></div>\n" +
    "        </td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"name\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"wins\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"losses\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" title=\"Handedness\" attribute=\"hand\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"position\"></td>\n" +
    "      </tr>\n" +
    "    </tbody>\n" +
    "  </table>\n" +
    "  <fs-beerpong-editor fs-beerpong-editor-current-roster-model=\"currentRosterModel\"></fs-beerpong-editor>\n" +
    "</div>"
  );


  $templateCache.put('view/team-list/directive/calvinball-table/team-list-calvinball-table.html',
    "\n" +
    "<div>\n" +
    "  <table at-table=\"at-table\" list=\"currentRosterModel.list\">\n" +
    "    <thead>\n" +
    "      <th attribute=\"active\"><i class=\"fa fa-bolt\"></i></th>\n" +
    "    </thead>\n" +
    "    <tbody>\n" +
    "      <tr ng-click=\"toggleSelectPlayer(item)\" ng-class=\"{'selected-row' : item.selected == true}\">\n" +
    "        <td attribute=\"active\">\n" +
    "          <div ng-show=\"item.active == true\"><i class=\"fa fa-check\"></i></div>\n" +
    "          <div ng-show=\"item.active == false\"><i class=\"icon-spacer\"></i></div>\n" +
    "        </td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"name\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"wins\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"losses\"></td>\n" +
    "        <td at-implicit=\"at-implicit\" attribute=\"rule\"></td>\n" +
    "      </tr>\n" +
    "    </tbody>\n" +
    "  </table>\n" +
    "</div>"
  );


  $templateCache.put('view/team-list/directive/roster-editor/team-list-roster-editor.html',
    "\n" +
    "<ul class=\"button-group\">\n" +
    "  <li><a ng-click=\"addPlayer()\" class=\"button\">Add player</a></li>\n" +
    "  <li><a ng-click=\"removeSelectedPlayers()\" class=\"button\">Remove players</a></li>\n" +
    "  <li><a ng-click=\"activateSelectedPlayers()\" class=\"button\">Activate players</a></li>\n" +
    "  <li><a ng-click=\"deactivateSelectedPlayers()\" class=\"button\">Deactivate players</a></li>\n" +
    "  <li ng-show=\"currentSport == BEERPONG\"><a ng-click=\"switchHandednessForSelectedPlayers()\" class=\"button\">Switch handedness</a></li>\n" +
    "</ul>"
  );


  $templateCache.put('view/team-list/directive/roster-table-container/team-list-roster-table-container.html',
    "\n" +
    "<div>\n" +
    "  <div ng-switch=\"currentSport\">\n" +
    "    <fs-team-list-calvinball-table ng-switch-when=\"CALVINBALL\" fs-team-list-calvinball-table-current-roster-model=\"currentRosterModel\"></fs-team-list-calvinball-table>\n" +
    "    <fs-team-list-beerpong-table ng-switch-when=\"BEERPONG\" fs-team-list-beerpong-table-current-roster-model=\"currentRosterModel\"></fs-team-list-beerpong-table>\n" +
    "  </div>\n" +
    "</div>"
  );


  $templateCache.put('view/team-list/directive/sport-navigation/team-list-sport-navigation.html',
    "\n" +
    "<dl class=\"sub-nav\">\n" +
    "  <dt>Edit team for:</dt>\n" +
    "  <dd ng-repeat=\"sport in sports\" ng-class=\"{'active' : currentSport == sport}\"><a ng-click=\"showSport(sport)\">{{sportNames[sport]}}</a></dd>\n" +
    "</dl>"
  );


  $templateCache.put('view/team-list/team-list-view.html',
    "\n" +
    "<h1>Fantasy\n" +
    "  <strike>football</strike>&nbsp;made-up sports\n" +
    "</h1>\n" +
    "<hr/>\n" +
    "<fs-team-list-sport-navigation fs-team-list-sport-navigation-current-sport=\"currentSport\"></fs-team-list-sport-navigation>\n" +
    "<fs-team-list-roster-editor fs-team-list-roster-editor-current-sport=\"currentSport\" fs-team-list-roster-editor-current-roster-model=\"currentRosterModel\"></fs-team-list-roster-editor>\n" +
    "<fs-team-list-roster-table-container fs-team-list-roster-table-current-sport=\"currentSport\" fs-team-list-roster-table-current-roster-model=\"currentRosterModel\"></fs-team-list-roster-table-container>"
  );

}]);
