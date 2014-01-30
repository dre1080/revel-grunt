Revel Grunt
======

[GruntJs](http://gruntjs.com) module for revel framework

[![baby-gopher](https://raw2.github.com/drnic/babygopher-site/gh-pages/images/babygopher-badge.png)](http://www.babygopher.org)


## Module Use

### app.init()

Add the following inside the app.init() function in `app/init.go`.

```go
package app

import "github.com/dre1080/revel-grunt"

func init() {
  revel.OnAppStart(grunt.AppInit)
}
```

And that's it! Grunt will now run in the background when you `revel run your-app` and you will see Grunt logs in your terminal.

See the example `Gruntfile.example.coffee`.
