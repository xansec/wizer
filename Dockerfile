# Build Stage
FROM rustlang/rust:nightly as builder

## Install build dependencies.
RUN cargo install -f cargo-fuzz

## Add source code to the build stage.
ADD . /wizer
WORKDIR /wizer

RUN cd fuzz && cargo fuzz build fuzz_wizer

# Package Stage
FROM ubuntu:20.04

COPY --from=builder /wizer/target/x86_64-unknown-linux-gnu/release/fuzz_wizer /
RUN mkdir /testsuite
COPY --from=builder /wizer/benches/*.wasm /testsuite/
