# Decomposing complex views

How do you break a large, complicated view into smaller pieces that fulfill DRY principles and clear separation of concerns? Here are some solutions.

This example project is an app that lets you manage fantasty teams for two sports: Beer Pong and Calvinball.

**Requirements:**

- You can choose which team to manage via a menu.
- Each team subview contains a table and a row of buttons. 
- The table displays sport-specific stats for your team.
- The row of buttons provides basic functionality that is shared by both teams (e.g. add player, remove player), as well as functionality that's specific to each team.

## Use directives to de-bloat view controllers

At a base level, a view is just a template + a controller. But views have a lot of responsibilities. They need to load data, manage the presentation of that data, handle user input, watch and react to changes on the scope, coordinate logic among injected services, and clean up after themselves. That's a lot of crap to stuff into two files!

I use directives to lighten the load.

# Misc

#### Should directives always be general or can they be specific to a view?

#### How do view-specific directives communicate with each other and the controller?

#### How do you apply DRY principles to a view that needs to subtly change behavior depending on its state?  
