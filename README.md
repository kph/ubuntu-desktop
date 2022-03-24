# ubuntu-desktop
This is a demonstration of running Ubuntu in a container as a desktop.
This is a full installation running using systemd and X11.

This will run a ssh server on port 2222. Connect as:

**ssh -p 2222 localhost**

The password will be *changeme*.

Quickstart:

	$ git clone https://github.com/kph/ubuntu-desktop
	$ ./run.sh
