FROM library/amazoncorretto:21-alpine
LABEL maintainer="John Stephenson, https://github.com/johnnyfleet"

HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:3220 || exit 1

ARG USERNAME=bliss
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN addgroup -S $USER_GID \
    && adduser -S -s /bin/sh $USERNAME -G $USER_GID -u $USER_UID \
    && apk add --update-cache curl bash \
    && apk -U upgrade && rm -rf /var/cache/apk/*

# Rev-locking this to ensure reproducible builds
#RUN wget -O /tmp/runas.sh 'https://raw.githubusercontent.com/coppit/docker-inotify-command/dd981dc799362d47387da584e1a276bbd1f1bd1b/runas.sh'
#RUN wget -O /tmp/mapids.sh 'https://github.com/coppit/docker-inotify-command/blob/439b1f0789f8b86b802447146f54a15c99e43331/mapids.sh'
#RUN chmod +x /tmp/runas.sh
#RUN chmod +x /tmp/mapids.sh

# Create non-root user
# RUN addgroup -S bliss && adduser -S bliss -G bliss

ENV UMASK 0000
ENV UMAP ""
ENV GMAP ""
ENV VMARGS=-Dbliss_working_directory=/config

RUN curl -L http://www.blisshq.com/app/latest-linux-version|xargs wget -O /tmp/latest.jar \
    && echo INSTALL_PATH=/bliss > /tmp/auto-install.properties \
    && java -jar /tmp/latest.jar -options /tmp/auto-install.properties \
#    && ln -s /root /config \
    && chown -R  bliss: /bliss

# Run as non-root by default
USER $USERNAME

CMD /bliss/bin/bliss.sh

VOLUME /config /music

EXPOSE 3220 3221
