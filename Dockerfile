FROM library/openjdk:17-bullseye
LABEL maintainer="John Stephenson, https://github.com/johnnyfleet"

HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:3220 || exit 1

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl bash

# Rev-locking this to ensure reproducible builds
#RUN wget -O /tmp/runas.sh 'https://raw.githubusercontent.com/coppit/docker-inotify-command/dd981dc799362d47387da584e1a276bbd1f1bd1b/runas.sh'
RUN wget -O /tmp/mapids.sh 'https://github.com/coppit/docker-inotify-command/blob/439b1f0789f8b86b802447146f54a15c99e43331/mapids.sh'
#RUN chmod +x /tmp/runas.sh
RUN chmod +x /tmp/mapids.sh

# Run as root by default

ENV USER_ID 0
ENV GROUP_ID 0
ENV UMASK 0000
ENV UMAP ""
ENV GMAP ""

RUN curl -L http://www.blisshq.com/app/latest-linux-version|xargs wget -O /tmp/latest.jar

RUN echo INSTALL_PATH=/bliss > /tmp/auto-install.properties
RUN java -jar /tmp/latest.jar -options /tmp/auto-install.properties
RUN ln -s /root /config
RUN chmod 777 /bliss
CMD /bliss/bin/bliss.sh


VOLUME /config /music

EXPOSE 3220 3221
