#!/bin/bash

# 安装Go
GO_VERSION="1.21.5"
echo "Installing Go ${GO_VERSION}..."
curl -sLJO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
tar -C /tmp -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
export PATH="/tmp/go/bin:$PATH"
export GOPATH="/tmp/go"
export GOROOT="/tmp/go"

# 验证Go安装
echo "Go version: $(go version)"

# 安装Hugo Extended
HUGO_VERSION="0.124.1"
echo "Installing Hugo Extended ${HUGO_VERSION}..."
curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz" | tar -xz -C /tmp
mv /tmp/hugo /usr/local/bin/hugo

# 验证Hugo安装
echo "Hugo version: $(hugo version)"

# 设置Git配置（用于Hugo Modules）
git config --global --add safe.directory /vercel/path0
git config core.quotepath false

# 构建网站
echo "Building Hugo site..."
hugo --gc --minify --baseURL "https://${VERCEL_URL}"