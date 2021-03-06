
Install
=======

Clone
++++++

First install Git_, Docker-engine_ and docker-compose_ and open a terminal.

On MacOS or Windows, you will maybe ned to install Docker-Toolbox_ and open a Docker Quickstart Terminal.

Then run these commands::

    git clone --recursive https://github.com/Ircam-Web/Mezzo.git


Start
+++++

Our docker composition already bundles some powerful containers and bleeding edge frameworks like: Nginx, MySQL, Redis, Celery, Django and Python. It thus provides a safe and continuous way to deploy your project from an early development stage to a massive production environment.

For a production environment setup::

    cd Mezzo

Copy the local_settings sample::

    cp app/local_settings.py.sample app/local_settings.py

and edit your own local_settings, especially the SECRET_KEY parameter. Then::

    bin/prod/up.sh

which builds, (re)creates, starts, and attaches all containers.

Then browse the app at http://localhost:8040/

On MacOS or Windows, you maybe need to replace 'localhost' by the IP given by the docker terminal.

.. warning :: Before any serious production usecase, you *must* modify all the passwords and secret keys in the configuration files of the sandbox.


Daemonize
+++++++++++

The install the entire composition so that it will be automatically run at boot and in the background::

    sudo bin/install/install.py

options::

    --uninstall : uninstall the daemon
    --cron : install cron backup rule (every 6 hours)
    --user : specify user for cron rule
    --systemd : use systemd
    --composition_file : the path of the YAML composition file to use (optional)

This will install a init script in /etc/init.d. For example, if your app directory is named `mezzanine-organization` then `/etc/init.d/mezzanine-organization` becomes the init script for the OS booting procedure and for you if you need to start the daemon by hand::

    sudo /etc/init.d/mezzo start


.. _Docker-engine: https://docs.docker.com/installation/
.. _docker-compose: https://docs.docker.com/compose/install/
.. _docker-compose reference: https://docs.docker.com/compose/reference/
.. _Docker-Toolbox: https://www.docker.com/products/docker-toolbox
.. _Git: http://git-scm.com/downloads
.. _NodeJS: https://nodejs.org
.. _Gulp: http://gulpjs.com/
.. _Mezzanine-Agenda : https://github.com/jpells/mezzanine-agenda
.. _Cartridge : https://github.com/stephenmcd/cartridge/
