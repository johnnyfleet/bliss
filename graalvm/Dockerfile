FROM ghcr.io/graalvm/jdk-community:17.0.7-ol7-20230622 AS build
#RUN gu install native-image
RUN microdnf install wget
RUN mkdir /build && wget https://www.blisshq.com/downloads/bliss-install-20230620.jar -O /build/app.jar
RUN cd /build && native-image -jar ./app.jar -H:Name=output

FROM debian:buster-slim
COPY --from=build /build/output /opt/output
CMD ["/opt/output"]

VOLUME /config /music

EXPOSE 3220 3221