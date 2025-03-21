FROM registry.access.redhat.com/ubi9/httpd-24:latest AS base

WORKDIR $APP_ROOT/app

COPY html /tmp/src/html
COPY httpd-cfg /tmp/src/httpd-cfg

FROM base AS dependencies

FROM base AS bundle

USER 0

WORKDIR $APP_ROOT/src
# Let the assemble script install the dependencies
RUN /usr/libexec/s2i/assemble
ENV HOME='/home'
RUN chown -R 1001:0 "/home"

RUN echo "|****** FINE BUNDLE *******|"

USER 1001

# The run script uses standard ways to run the application CMD run-httpd
CMD /usr/libexec/s2i/run