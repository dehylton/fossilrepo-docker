FROM alpine:latest

ENV USERNAME __fossil

RUN addgroup -Sg 400 g$USERNAME \
  && adduser -Su 400 -G g$USERNAME $USERNAME \
  && apk add --no-cache alpine-sdk zlib-dev openssl-libs-static zlib-static openssl-dev tcl fossil \
  && mkdir -p /usr/local/src/fossils/ \
  && cd /usr/local/src/fossils \
  && fossil clone http://www.fossil-scm.org/fossil fossil.fossil --user $USERNAME --workdir fossil-src \
  && cd fossil-src \
  && ./configure --static --disable-fusefs --with-th1-docs --with-th1-hooks \
  && make \
  && make install \
  && strip /usr/local/bin/fossil \
  && cd /tmp \
  && rm -fr /usr/local/src \
  && apk del --purge --no-cache fossil alpine-sdk zlib-dev openssl-dev tcl openssl-libs-static zlib-static \
  && rm -f /var/cache/apk/*

VOLUME ["/fossils"]

WORKDIR ["/fossils"]

EXPOSE 8181

ENTRYPOINT ["/usr/local/bin/fossil"]

CMD ["server","--repolist","--port","8181","--skin","darkmode","/fossils"]
