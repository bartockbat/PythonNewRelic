### docker build --pull -t acme/starter-arbitrary-uid -t acme/starter-arbitrary-uid:v3.2 .
FROM registry.access.redhat.com/rhel7
MAINTAINER Red Hat Systems Engineering <refarch-feedback@redhat.com>

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="acme/starter-arbitrary-uid" \
      vendor="Acme Corp" \
      version="3.2" \
      release="1" \
### Recommended labels below
      url="https://www.acme.io" \
      summary="Acme Corp's Starter app" \
      description="Starter app will do ....." \
      run='docker run -tdi --name ${NAME} \
      -u 123456 \
      ${IMAGE}' \
      io.k8s.description="Starter app will do ....." \
      io.k8s.display-name="Starter app" \
      io.openshift.expose-services="" \
      io.openshift.tags="acme,starter-arbitrary-uid,starter,arbitrary,uid"

### Atomic Help File - Write in Markdown, it will be converted to man format at build time.
### https://github.com/projectatomic/container-best-practices/blob/master/creating/help.adoc
COPY help.1 /tmp/
COPY help.1 /

### add licenses to this directory
COPY licenses /licenses

#Needed EPEL for pip - not included with RHEL
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#Installing pip and python for the test script/agent
RUN yum -y install python2-pip

#The INI file - make sure you put your license in here or it won't work!
COPY newrelic.ini /

#Install the NewRelic Agent
RUN pip install newrelic

#The agent needs to know where the INI file is
ENV NEW_RELIC_CONFIG_FILE=/newrelic.ini

#Script to run the Python Agent test 5 times to make sure you get a good reading in the web UI
COPY runit5times.py /

#When you launch the container, it runs the script and then exits
ENTRYPOINT ./runit5times.py
