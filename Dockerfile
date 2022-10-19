ARG MATTS_ENV
FROM debian:stretch
RUN echo "$MATTS_ENV"

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
