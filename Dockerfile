FROM debian:stretch

WORKDIR /webdis
COPY webdis ./src
COPY webdis-wrapper.sh .
RUN  apt-get update && apt-get -y install wget make gcc libevent-dev \
	&& cd src && make && cp /webdis/src/webdis /webdis/webdis && rm -rf /webdis/src
	
ARG MATTS_ENV
echo "**** GET READY **** GET SET ****"
RUN if [ "$MATTS_ENV" ]; then echo "HERE IT IS: $MATTS_ENV"; fi

ENV PATH=/webdis:$PATH

CMD ["/webdis/webdis-wrapper.sh"]
