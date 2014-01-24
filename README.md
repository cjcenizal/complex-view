# Broman

Broman is a dangerously suggestful methodology for seeding your projects with the following technologies:

 * [AngularJS](http://angularjs.org/)
 * [Font Awesome](http://fontawesome.io/)
 * [Foundation](http://foundation.zurb.com/)
 * [HTML5 Boilerplate](http://html5boilerplate.com/)
 * [jQuery](http://jquery.com/)
 * [Modernizr](http://modernizr.com/)

And written without html, css, or javascript using:

* [CoffeeScript](http://coffeescript.org/)
* [Jade](http://jade-lang.com/)
* [Stylus](http://learnboost.github.io/stylus/)

## So what does this buy me?

The bro is perfect for people who want to get started developing without the headache of setting up a development environment every time. The project has already configured the basics of compilation, watcher, and a server tasks.

It also comes with a biased folder structure that accommodates both small and large projects.

## Quick start

1. Install [node](http://nodejs.org/) - *windows users will have to add nodejs to environment path*
2. Install [npm](http://nodejs.org/download/) - *windows users will have to add npm to environment path*
3. Install [grunt](http://gruntjs.com/); run `npm install -g grunt-cli`
4. Install [bower](http://bower.io/); run `npm install -g bower`
5. Install npm depedencies; run `npm install -d`
6. Install bower dependencies; run `bower install`
7. Compile, run, watch, develop; run `grunt`

## Folder structure *concept*

After you execute the ```grunt``` command, along with installing the dependencies for npm and bower, your project will look a lot different. Orly?

See below for folder structure intended by the creator:

```
broman/
├── dist/ (website files to be distributed - do not touch)
├── src/ (website files to be edited)
│   ├── app/
│   │   ├── feature-a/
│   │   │   ├── controller/
│   │   │   ├── directive/
│   │   │   ├── filter/
│   │   │   ├── model/
│   │   │   ├── service/
│   │   │   ├── style/
│   │   │   ├── test/
│   │   │   ├── _feature-a.jade (partials are "_" prefixed file names)
│   │   │   └── feature-a.jade (pages are non prefixed file names)
│   │   ├── layout/ (generic layout)
│   │   │   ├── controller/
│   │   │   │   ├── footer-controller.jade
│   │   │   │   └── header-controller.jade
│   │   │   ├── _footer.jade
│   │   │   └── _header.jade
│   │   ├── shared/ (shared features)
│   │   │   ├── component/ (generic components)
│   │   │   │   └── component-a/
│   │   │   │       ├── directive/
│   │   │   │       ├── service/
│   │   │   │       ├── style/
│   │   │   │       └── _component.jade
│   │   │   ├── filter/
│   │   │   │   └── test/
│   │   │   ├── model/
│   │   │   │   └── test/
│   │   │   └── service/
│   │   │       └── test/
│   │   ├── app.coffee
│   │   └── index.jade (html5 boilerplate port)
│   ├── asset/ (site static content)
│   ├── img/ (site images)
│   ├── font/ (site fonts)
│   └── style/
│       ├── components/ (generic css only components)
│       │   └── foundation/ (foundation overrides)
│       ├── mixin/
│       ├── app.styl
│       ├── base.styl (tag customization excluding font)
│       ├── font.styl (font family additions)
│       ├── icon.styl
│       ├── typography.styl (font styles)
│       └── variable.styl (website colors, etc)
│
├── vendor/
│   └── bower/ (managed by bower - do not touch)
├── .bowerrc
├── .gitignore
├── bower.json
├── Gruntfile.coffee
├── package.json
└── README.md
```
