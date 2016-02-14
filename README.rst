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

this application is intended to be built as an openshift
source-to-image image. for more information on source-to-image, please
see https://github.com/openshift/source-to-image

to build and run this application with s2i and docker, use the
following commands (or something similar to your settings):

**note** the openshift/python-27-centos7 image in the following example
is not sufficient to run spark.

::

    $ s2i build https://github.com/sparkhara/whirlwind-caravan \
      openshift/python-27-centos7 whirlwind-caravan-centos7

    (... lots of build exhaust ...)

    $ docker run --rm -i -t -p 1984:1984 \
      -e PATHFINDER_BROKER_URL=amqp://127.0.0.1/ \
      whirlwind-caravan-centos7

    (log output from whirlwind-caravan)

message formats
---------------

for optimal processing, the lines sent to the caravan should be json
strings which conform to the following format:

::

    {
        "name": "log line"
    }

