FROM alpine:latest

RUN apk update && apk add bash clang

RUN echo "alias aoc='clang++ -Wall -o main main.cpp && ./main'" >> /root/.bashrc

ENV SHELL=/bin/bash
