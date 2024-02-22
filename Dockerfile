FROM codercom/code-server:latest

USER 0
RUN curl -fsSL https://deb.nodesource.com/setup_21.x |  bash -
RUN apt-get update &&  apt-get install -y --no-install-recommends python3 nodejs

RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.bashrc" SHELL="$(which bash)" bash -

ARG GO_VERSION=1.22.0
ARG GO_FILE=go$GO_VERSION.linux-amd64.tar.gz
RUN wget -q https://go.dev/dl/$GO_FILE
RUN  tar -C /usr/local/ -xzf $GO_FILE
RUN echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
RUN rm $GO_FILE
COPY install_extensions.sh /home/coder/entrypoint.d/
USER 1000