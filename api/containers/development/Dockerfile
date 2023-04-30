FROM elixir:1.14.4

ENV LANG C.UTF-8

WORKDIR /api

ARG CHROME_VERSION="112.0.5615.165-1"
ARG CHROMEDRIVER_VERSION="112.0.5615.49"

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
    inotify-tools \
    libopenblas-dev \
    cmake \
    google-chrome-stable=${CHROME_VERSION} \
    && mix local.hex --force \
    && mix local.rebar \
    && mix archive.install hex phx_new 1.7.2

ADD https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip /usr/local/bin
RUN cd /usr/local/bin && unzip chromedriver_linux64.zip
