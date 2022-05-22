FROM ghcr.io/graalvm/graalvm-ce:20.3.6 AS build
RUN gu install native-image
RUN microdnf install wget
RUN mkdir /build && wget https://www.blisshq.com/downloads/bliss-install-20220513.jar -O /build/app.jar
RUN cd /build && native-image -jar ./app.jar -H:Name=output

FROM debian:buster-slim
COPY --from=build /build/output /opt/output
CMD ["/opt/output"]

VOLUME /config /music

EXPOSE 3220 3221