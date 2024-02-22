FROM codercom/code-server:latest

RUN curl -fsSL https://deb.nodesource.com/setup_21.x | sudo bash -
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends python3 nodejs
RUN sudo npm install -g pnpm

ARG GO_VERSION=1.22.0
ARG GO_FILE=go$GO_VERSION.linux-amd64.tar.gz
RUN wget -q https://go.dev/dl/$GO_FILE
RUN sudo tar -C /usr/local/ -xzf $GO_FILE
RUN echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
RUN rm $GO_FILE
COPY install_extensions.sh /entrypoint.d/
RUN sudo chmod +x /entrypoint.d/install_extensions.sh
