# rake-to-web

*rake-to-web is a mechanism that can be added to a ruby project with
an existing Rakefile so that all of the tasks in that Rakefile can be
invoked via http*

[![Build Status](https://travis-ci.org/jedcn/rake-to-web.png)](https://travis-ci.org/jedcn/rake-to-web)

## Quick Start

If you've got a Rakefile with tasks that you love, then:

* Add `gem 'rake-to-web'` to your `Gemfile`, and `bundle` (or `gem
  install rake-to-web`

* Add `require rake-to-web` to your `Rakefile`

* You should now have a Rake task named `to-web`

* Type `rake to-web` and open your browser to http://localhost:4567.

## Overview

Many rubyists reach for rake as a standard part of their toolkit. They
might create a rake task to..

* Describe how to complete an annoying task and be able to repeatably
  re-execute it.
* Break a larger task down into distinct tasks, and then be able to
  execute these smaller tasks independently.
* Possible setup a graph of task dependencies and using the power of
  Rake ensure that all of the dependencies are completed by issuing a
  single command.

That said, most Rakers can figure out what tasks are available in a
project by running this command:

    rake -T

And then a Raker could execute any one of these tasks by running

    rake taskname

## What if..

What there was a small web application that, at start up, did the
equivalent of running a `rake -T` and built http routes for every
task?

What this web application responded to `GET /` by showing an index
page of all of these tasks?

What if, when you had a task named `generate:files`, this web
application made it so that you could `GET /generate/files`?

What if when you issued a `POST /generate/files` this web application
made it so that `rake generate:files` was invoked, and the results
were returned?

What if you started this web application by installing the rake-to-web
gem, then adding the following to a Rakefile:

    require 'rake-to-web'

And this require statement gave your project a new rake task:

    rake to-web

And running this rake task brought the server into existence at
http://localhost:4567, bound just to the loopback so no one else could
interact with this web app and it was all about your Rakefile?

## Introducing rake-to-web

That's what rake-to-web is.

This is probably crazy.

This is crazy if your tasks are not small and do not return quickly.

This is crazy if your tasks are not properly thought out with regard
to security.

But, it might be helpful if you want to provide easy web access to a
few rake tasks made just for this purpose.
