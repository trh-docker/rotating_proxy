FROM quay.io/spivegin/brook:latest AS brook
FROM quay.io/spivegin/gobetween:latest AS gobetween
FROM quay.io/spivegin/tlmbasedebian
MAINTAINER TRH <docker@trhhosting.com>
ENV DINIT=1.2.4 \
    DEBIAN_FRONTEND=noninteractive \
    PROXY_PASSWORD=7tkjmbvgpoeqrzyius4hafHdc9x3w \
    PROXY_DOMAIN=""
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.4/dumb-init_${DINIT}_amd64.deb /tmp/dumb-init.deb

RUN apt-get update && apt upgrade -y &&\
    apt-get install -y apt-transport-https gnupg2 curl proxychains psmisc nano procps lsof && \
    dpkg -i /tmp/dumb-init.deb &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /root/*    

RUN mkdir /opt/bin && \
    echo deb https://deb.torproject.org/torproject.org stretch main >> /etc/apt/sources.list.d/tor.list && \
    curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - &&\
    apt update &&\
    apt install -y tor deb.torproject.org-keyring &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /root/*    

COPY --from=gobetween /opt/bin/gobetween /opt/bin/gobetween
RUN chmod +x /opt/bin/gobetween && \
    ln -s /opt/bin/gobetween /bin/gobetween

COPY --from=brook /opt/bin/brook /opt/bin/brook
RUN chmod +x /opt/bin/brook && \
    ln -s /opt/bin/brook /bin/brook

WORKDIR /root/
ADD files/gobetween/gobetween.json /root/gobetween.json
ADD files/bash/entry.sh /root/entry.sh

RUN chmod +x /root/entry.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/root/entry.sh"]