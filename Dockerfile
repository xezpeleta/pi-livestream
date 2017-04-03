FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get -qy install \
      libjpeg8-dev \
      imagemagick \
      libv4l-dev \
      curl \
      build-essential \
      cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/

RUN curl -L -o mjpg-streamer.tar.gz https://github.com/jacksonliam/mjpg-streamer/archive/master.tar.gz
RUN mkdir mjpg-streamer && tar -xvzf mjpg-streamer.tar.gz -C mjpg-streamer --strip-components 2
RUN sudo ln -s /usr/include/libv4l1-videodev.h /usr/include/linux/videodev.h

WORKDIR /root/mjpg-streamer/
RUN sed -e '/PLUGINS += input_gspcav1\.so/ s/^#*/#/' -i Makefile
RUN make

CMD ["echo", "finished"]

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /dev
VOLUME /lib/modules
EXPOSE 80
