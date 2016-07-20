FROM debian:8.5 
MAINTAINER Victor Fernandez <victor.j.fdez@gmail.com>

#Download and patch installer
RUN apt-get update && apt-get install -y curl bash patch

#Get Meteor installer
COPY patch ./
RUN curl https://install.meteor.com/ -o meteor_install.sh && \
    patch meteor_install.sh patch && \
    chmod u+x meteor_install.sh

ARG BUILD_METEOR_VERSION
ENV BUILD_METEOR_VERSION ${BUILD_METEOR_VERSION:-1.3.5}
#Run installer for the specified version
RUN ./meteor_install.sh $BUILD_METEOR_VERSION && rm -f meteor_install.sh

#Change to workdir
WORKDIR /var/meteor/
VOLUME /var/meteor/

CMD sh
