# Decomposing complex views

Architecting an Angular app can be tricky, especially as it grows in complexity.  How do you break it up and keep code modular?

I’m not a sports guy, but I know beer pong and [Calvinball](http://4.bp.blogspot.com/_zRSvuGbL2L0/TE0I0GlkcTI/AAAAAAAAAg4/kpmU0AfcOAA/s1600/Calvinball%2B5-27-90.jpg), so to illustrate some solutions to this problem, I made an app for managing my fantasy teams for these two classic sports. See it in action at http://cjcenizal.github.io/complex-view.

**Gotta stay focused!**

There’s a lot of services in this app that support the app’s functionality, but I’m going to gloss over them and stay focused on how the main view is broken up into pieces and organized.

#### Scaleble folder structure

Inspired by [Broman by Carey Hinoki](https://github.com/chemoish/broman), but the organizing principle reolves around views, directives, and different uses of services (as enums, mixins, models, etc).

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

We want small, bite-size files with laser-focused concerns and logical organization.  This folder structure can expand to accommodate lots of files.  Lots of files means each file can be smaller, which is great because we want each file's concern to be very narrowly-defined.  Work complete.

Controller                | Concern
------------------------ | --------------------------------------------------------------
team-list-view                | Initialize roster models. Maintain state of current sport and current roster model.

Directive                | Concern
------------------------ | --------------------------------------------------------------
sport-navigation         | Allow user to change the current sport.
roster-editor            | Connect UI to an API that calls methods on the current roster model.
roster-table-container   | Present correct table for current sport and provide row-selection logic.
calvinball-table         | The name speaks for itself. Goes inside roster-table-container.
beerpong-table           | Like the calvin-ball table… for beer. Pong.
beerpong-editor          | Some extra functionality for editing just the beerpong-table.

We *could* have left all this logic in the controller.  But then we’d have a massive controller file, it’d be a pain in the groin to maintain, and baby Jesus would cry. Instead, we did the courteous thing and we used directives to break up our controller’s concerns into many small files.

#### Isolating those scopes

With a lot of directives comes a lot of responsibility. Many of these directives depend on scope properties on the view’s controller.  All of our directives in this view use isolate scopes, and we pass dependencies from parent to child through directive attributes.

Here’s how our controller and directive templates are nested:

```
team-list-view --- sport-navigation
                  roster-editor
                  roster-table-container --- calvinball-table
                                             beerpong-table --- beerpong-editor             
```

[Like good parents](https://www.youtube.com/watch?v=1tWLDhJ6mjQ), each directive provides its child with the scope dependencies that child needs.  This takes discipline, but it’s better than all your directives sharing the same scope and stepping on each others’ toes.

#### Long-distance communication between different parts in the app

If our directives have narrowly-defined scopes, then they’re going to have to work as a team to win the game that is life.  How does one part of the app tell another part of the app, “Hey buddy, a user just clicked a button I’m responsible for, and now I’m going to need you to file some TPS reports”?

One option is to use Angular’s scope-bound event system ($broadcast, $emit, and $on). For the majority of cases, this is the right solution.  If you want to communicate without bubbling events throughout the entire scope tree, you can implement a pub/sub pattern with services.  In the case of this app, we’re using a simple system of signal services, inspired by [Robert Penner’s AS3 Signals](https://github.com/robertpenner/as3-signals).

#### Extract reusable logic into services

Adhering to the “fat model, skinny controller” paradigm, a lot of our logic for manipulating model data has gone into the models.  But really, even models shouldn’t be fat.  None of our files should turn into dumping grounds for unwanted responsibility.  So we also have a bestiary of services to contain helper logic, constants and enums data, and mixins to keep our code DRY and modular.

#### Fin

Thanks for checking this out!  Please email me if you have any questions about this stuff or any suggestions on how I can improve it!

## Credits

- Built for the [Social Angular Meetup](http://www.meetup.com/socal-angular).
- Learned most of this stuff while at [Shift](www.shift.com).
- Starter template courtesy of [Broman](https://github.com/chemoish/broman).