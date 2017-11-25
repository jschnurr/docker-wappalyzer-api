FROM golang:1.8-jessie

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
  gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends \
	# && apt-get purge --auto-remove -y curl gnupg \
	&& rm -rf /var/lib/apt/lists/*

# Install Go dependencies
RUN go get github.com/wirepair/autogcd
RUN go get github.com/tools/godep

# Copy source for the build
ADD . /go/src
WORKDIR /go/src

# Copy vendored package
# ADD extraction/ /go/src/extraction
RUN godep restore

# Compile source
RUN env GOOS=linux GOARCH=amd64 go build -o server

# Copy the binary server
RUN cp /go/src/server /usr/local/bin/wappalyzer-server

# Copy the JS files
# RUN cp /go/src/extraction/js/* extraction/js

EXPOSE 3001

ENTRYPOINT ["wappalyzer-server", "-chromePath", "/usr/bin/google-chrome-stable"]
