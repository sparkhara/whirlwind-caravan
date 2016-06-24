whirlwind caravan
=================

**warning** this is very much work in progress currently, **do not**
expect it to run out of the box.

the whirlwind caravan is a spark application that processing incoming
lines on a text socket, normalizes the data, stores the data in a
mongo database, and then signal a rest application.

it is intended to be used as the heart of a distributed application
which includes the sparkhara/caravan-pathfinder and
sparkhara/shiny-squirrel.


installation and execution
--------------------------

this application can be built using the docker file in the root. to
deploy it, the openshift templates in the tools directory provide
some clues as to how it should started.

message formats
---------------

for optimal processing, the lines sent to the caravan should be json
strings which conform to the following format:

::

    {
        "name": "log line"
    }

