FROM ubuntu:xenial

RUN mkdir nginx
WORKDIR /nginx

RUN apt-get -y update
RUN apt-get -y install git gcc make libpcre3-dev libssl-dev wget
RUN git clone git://github.com/arut/nginx-rtmp-module.git

RUN wget http://nginx.org/download/nginx-1.12.0.tar.gz
RUN tar xzf nginx-1.12.0.tar.gz
WORKDIR /nginx/nginx-1.12.0

RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --with-http_stub_status_module
RUN make
RUN make install

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

ENV PATH="/usr/local/nginx/sbin/:${PATH}"

EXPOSE 1935
EXPOSE 80
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]