Schedule generation for soccer teams
====================================

What it is ?
------------

The year is 2009, and I'm doing a scheduling course
at university. The professor asked for a project and
I came up with this one.

Given a set of teams, their cities and their level,
it generates an schedule for one season.

Nice, but how do I execute it ?
-------------------------------

Do you have ruby installed on your computer ? Run this:

  $ ruby -v

You will see something like this:

  ruby 1.8.7 (2009-06-12 patchlevel 174) [i686-linux]

In the bin directory, which is a subdirectory of
code, you have a file called schedule_generator.rb. Simply execute
it using ruby

  $ ruby schedule_generator.rb

Or, just do this
  
  $ schedule_generator.rb

It will display a help. But I don't want you to read the help and this, so 
I will explain here. You will see that you need a team description file. 
There are two examples in code/data subdirectory. So here is one example:

  $ schedule_generator.rb ../data/paulistao_2010


What is the doc directory?
--------------------------

The professor asked me to write a proposal and a cronogram. So I wrote them and 
put them in the doc directory. You are free to see my tex files.

