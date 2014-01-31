# Decomposing complex views

Architecting an Angular app can be tricky, especially as it grows in complexity.  How do you break it up and keep code modular?

I’m not a sports guy, but I know beer pong and Calvinball, so I made an app for managing my fantasy teams for these two classic sports. See it in action at http://cjcenizal.github.io/complex-view.

**Gotta stay focused!**

There’s a lot of cool services in this app that support the app’s functionality, but I’m going to gloss over them and stay focused on how the main view is broken up into pieces and organized.

#### Folder structure

Inspired by [Broman by Carey Hinoki](https://github.com/chemoish/broman), but more focused on organizing by views, directives, and types of services (enums, mixins, models, etc).

```
├── app.coffee
├── index.jade
├── layout   <--- Global layout elements go here (toasts, modals, alerts, header bar)
│   └── toast-list
│       ├── signal
│       │   └── show-toast-signal.coffee
│       ├── toast-list-controller.coffee
│       └── toast-list.jade
├── shared   <--- Reusable components (directives) and services
│   ├── component
│   └── service
│       ├── enum-factory.coffee
│       ├── mixin-factory.coffee
│       └── signal-factory.coffee
└── view   <----- Create a folder for each of your views in here
    └── team-list
        ├── directive
        │   ├── beerpong-editor
        │   │   ├── beerpong-editor-directive.coffee
        │   │   └── beerpong-editor.jade
        │   ├── beerpong-table
        │   │   ├── team-list-beerpong-table-directive.coffee
        │   │   └── team-list-beerpong-table.jade
        │   ├── calvinball-table
        │   │   ├── team-list-calvinball-table-directive.coffee
        │   │   └── team-list-calvinball-table.jade
        │   ├── roster-editor
        │   │   ├── team-list-roster-editor-directive.coffee
        │   │   └── team-list-roster-editor.jade
        │   ├── roster-table-container
        │   │   ├── team-list-roster-table-container-directive.coffee
        │   │   └── team-list-roster-table-container.jade
        │   └── sport-navigation
        │       ├── team-list-sport-navigation-directive.coffee
        │       └── team-list-sport-navigation.jade
        ├── service
        │   ├── enum
        │   │   └── sport-enum.coffee
        │   ├── helper
        │   │   └── roster-model-helper.coffee
        │   ├── mixin
        │   │   └── roster-mixin.coffee
        │   ├── model
        │   │   ├── beerpong-roster-model.coffee
        │   │   └── calvinball-roster-model.coffee
        │   └── signal
        │       ├── team-list-deselect-players-signal.coffee
        │       └── team-list-toggle-select-player-signal.coffee
        ├── team-list-view-controller.coffee
        └── team-list-view.jade
```

#### What’s the point?

Small, bite-size files with laser-focused concerns and logical organization.  Our folder structure can expand to accommodate lots of files, so let’s take advantage of that.  Lots of files means each file can be smaller, which is great because we want each file's concern to be very narrowly-defined.

Directive                | Concern
------------------------ | --------------------------------------------------------------
team-list                | Init roster models. Maintain state of current sport and current roster model.
sport-navigation         | Allow user to change the current sport.
roster-editor            | Connect UI to an API that calls methods on the current roster model.
roster-table-container   | Present correct table for current sport and provide row-selection logic.
calvinball-table         | The name speaks for itself. Goes inside roster-table-container.
beerpong-table           | Like the calvin-ball table… for beer. Pong.
beerpong-editor          | Some extra functionality for editing just the beerpong-table.

Normally, all of this logic could have been chucked in the controller, but that would have resulted in a massive file that would have been a bear to maintain.  We’ve used directives to separate the controller’s concerns into multiple files.

#### Interfacing between directive parent and child

[Passing attributes, avoid globals but provide explicit dependencies, isolated scopes]

#### Communicating between different parts in the app

[Using scope.broadcast, emit, and on, and using signals]

#### Keeping controllers (and directives) skinny

[Putting logic, constants, and configuration data in services as helpers, constants/enums, and services]

## Credits

- Built for the [Social Angular Meetup](http://www.meetup.com/socal-angular).
- Learned most of this stuff while at [Shift](www.shift.com).
- Starter template courtesy of [Broman](https://github.com/chemoish/broman).