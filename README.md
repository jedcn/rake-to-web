# rake-to-web

*rake-to-web is a mechanism that can be added to a ruby project with
an existing Rakefile so that all of the tasks in that Rakefile can be
invoked by a web browser*

## Overview

Many rubyists reach for rake as a standard part of their toolkit. They
might create a rake task to..

* Describe how to complete an annoying task and be able to repeatably
  re-execute it.
* Break a larger task down into distinct tasks, and then be able to
  execute these tasks independently or setup a graph of task
  dependencies and, one way or another, ensure that all of the tasks
  are completed by issuing a single command.

That said, you can figure out what tasks are available in a project by
running this command:

    rake -T

And you can execute any one of these tasks by running

    rake taskname

## What if..

What if you made a small web application that, at start up, ran
```rake -T``` and built routes for everything task found?

What if you made it so that this web application responded to ```GET
/``` by showing an index of all of these tasks?

What if, when ```rake -T``` said you had a task named
```generate:files```, this small web application made it so that you
could ```GET /generate/files```?

What if when you issued a ```POST /generate/files``` this small web
application made it so that ```rake generate:files``` was invoked, and
the results were returned?

What if you started this web application by install the rake-to-web
gem, then adding the following to a Rakefile:

    require 'rake-to-web'

And this require statement gave your project a new rake task:

    rake to-web

And running this rake task brought the server into existence focused
on your Rakefile?

## Introducing rake-to-web

That's what rake-to-web is.

This is crazy if your tasks are not small and do not return quickly.

This is crazy if your tasks are not properly thought out with regard to
security.

But, it might be helpful if you want to provide easy web access to a
few rake tasks made just for this purpose.
