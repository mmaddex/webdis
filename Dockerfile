FROM debian:stretch

ARG MATTS_ENV
ARG GROUP_ENV

RUN echo "$MATTS_ENV"
RUN echo $GROUP_ENV
ARG TEST
ARG SECOND_TEST

ENV TEST=$GROUP_ENV
ENV SECOND_TEST=hay

RUN echo $TEST
RUN echo $SECOND_TEST

RUN --mount=type=secret,id=sec,dst=/etc/secrets/sec cat /etc/secrets/sec
RUN echo $SECRET_SECRET

WORKDIR /webdis
COPY webdis ./src
COPY webdis-wrapper.sh .
RUN  apt-get update && apt-get -y install wget make gcc libevent-dev \
	&& cd src && make && cp /webdis/src/webdis /webdis/webdis && rm -rf /webdis/src
	
RUN echo "**** GET READY **** GET SET ****"

RUN echo "$MATTS_ENV"
RUN if [ "$MATTS_ENV" ]; then echo "HERE IT IS: $MATTS_ENV"; fi

ENV PATH=/webdis:$PATH

CMD ["/webdis/webdis-wrapper.sh"]
