# builds the books and runs the correctness test, nothing needed on the host but docker
# docker build -t limit-order-book .
# docker run --rm limit-order-book
# (perf.Dockerfile is the separate image we used for the perf runs)
FROM ubuntu:24.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends g++ make && rm -rf /var/lib/apt/lists/*
WORKDIR /src
COPY Makefile bench.cpp *.hpp ./
RUN make bench
CMD ["./bench", "--verify"]
