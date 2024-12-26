FROM ubuntu:20.04
ARG TZ=Europe/Brussels
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y build-essential libmpc-dev gcc texinfo bison flex git python3 automake

ENV PATH=/workspace/build/avrtools/bin/:$PATH
