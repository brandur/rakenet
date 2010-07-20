Rakenet
=======

Command line build and testing infrastructure for a .NET project.

Installation
------------

1. Have a shell and Rubygems

2. Put the files from this project in your project's root, open `Rakefile` and replace any instances of `Path/To/My/Solution`

3. Install Rake with `gem install rake` and Bundler with `gem install bundler`

4. In your project's root, run `bundle install`

For more information see [Mutelight](http://mutelight.org/articles/building-a-command-line-environment-for-net-development-with-rake.html).

Usage
-----

Get a list of tasks with `rake -T`. Here are the important ones:

* `rake build` &mdash; build the project
* `rake build:release` &mdash; build the project with release configuration
* `rake test` &mdash; run our test suite (I'm using the MSTest framework here)
* `rake server` &mdash; start a development server pointing to our project for ASP.NET

License
-------

This software is open source and licensed under the BSD license, see the included LICENSE file for details.

