# PythonNewRelic

This is a test application for the New Relic Python plugin
Instructions for building and running:
1. Download/clone this git repo
2. Go to https://www.newrelic.com and obtain a license key (offer trial licenses)
3. Edit the newrelic.ini file - find the following:
..4. `license_key = XXXXXXXXXXX` <-- replace this with your license key
4. Save the file
5. Build the Docker image `docker build -t rhel72/newrelicpython:oss .`
6. Once the image is built, launch the container:
..6. `docker run rhel72/newrelicpython:oss`
7. This will launch the container and send 5 test messages to your NewRelic account

