FROM alpine:latest

RUN apk update && \
    apk add --no-cache bash fortune netcat-openbsd perl perl-utils

RUN wget -qO- https://github.com/tnalpgge/rank-amateur-cowsay/archive/master.tar.gz | tar zx && \
    cd rank-amateur-cowsay-master && \
    ./install.sh

WORKDIR /wisecowapp

COPY wisecow.sh .

RUN chmod +x wisecow.sh

EXPOSE 4499

ENTRYPOINT ["./wisecow.sh"]
