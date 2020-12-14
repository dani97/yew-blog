FROM rust:1.48-slim-buster

RUN apt-get update && apt-get install libssl-dev
RUN apt-get update -y && apt-get install -y pkg-config
RUN cargo install wasm-pack
RUN cargo install simple-http-server

WORKDIR /usr/src/blog
COPY . .

RUN wasm-pack build --target web --out-name wasm --out-dir ./static

EXPOSE 8080
CMD ["sh",  "-c", " simple-http-server -i --nocache --cors --port 8080 static/ "]