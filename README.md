# Decomposing complex views

How do you break a large, complicated view into smaller pieces that fulfill DRY principles and clear separation of concerns? Here are some solutions.

This example project is an app that lets you manage fantasty teams for two sports: Beer Pong and Calvinball.

**Requirements:**

- User can choose which team to manage via a menu.
- Each team subview contains a table and a row of buttons. 
- The table displays sport-specific stats for user's teams.
- The row of buttons provides basic functionality that is shared by both teams (e.g. add player, remove player), as well as functionality that's specific to each team.

#### Use view directives to extend view controllers

Functionally, these requirements mean our view needs to load the user's account data, manage the presentation of that data, handle user input, watch and react to changes on the scope, coordinate logic among injected services, and clean up after itself on $destroy.

A view is just a template + a controller, and that's a crapton of crap to stuff into two files! We can use directives to lighten the load.

My directives' template hierarchy looks like this:

```
team-list-view
├── team-list-sport-navigation
├── team-list-roster-editor
└── team-list-roster-table
    ├── team-list-calvinball-table
    └── team-list-beerpong-table
        └──  beerpong-editor
```

`team-list-view` loads the user's teams and exposes an API for editing them. It also exposes an API for navigating the teams.

`team-list-roster-table` displays the table for the user-selected team, and exposes an API for selecting and de-selecting the players in the table.

`team-list-calvinball-table` and `team-list-beerpong-table` are concerned with any specific logic for that team's table.

These additional files let me offload logic from the controller and group it into specific concerns.

#### Use isolated scope to declare dependencies

Isolated scope is bad for component directives that need to play nicely with other directives, e.g. input-validation directives that work with ng-model.  But when breaking a view down into nested templates and directives, you want to avoid implicitly relying on properties and methods on an inherited scope.

Isolated scopes force dependencies to be explicit, encouraging more descriptive and maintainable code.  Since you have to explicitly provide dependencies to a directive via attributes, you also gain some clues about a directive's role just by looking at how it's used in the template.

#### Connect different parts of your app with events

There are a few ways to pass data and messages between directives.

If you want to pass a dependency, then use an attribute.  Don't group dependencies in a single object; instead create as many attributes as you need, 1 per dependency.  This is one way to expose your API, but it's tricky passing a method to nested isolated scopes.

You can also use the scope event system, though this can be inefficient and obscure your view's logic.

I like to use signal services instead.  These are services the implement the observer pattern.  Because they're services, you can register handler functions anywhere in your view, and dispatch them from anywhere.  This uncouples your event system from your scope hierarchy, and keeps your events tightly scoped to your view.

#### Skinny controllers, fat models

## Questions

#### Should directives always be general or can they be specific to a view?

#### How do view-specific directives communicate with each other and the controller?

#### How do you apply DRY principles to a view that needs to subtly change behavior depending on its state?  

# Credits

- Built for the [Social Angular Meetup](http://www.meetup.com/socal-angular).
- Learned most of this stuff while at [Shift](www.shift.com).
- Project template courtesy of [Broman](https://github.com/chemoish/broman).