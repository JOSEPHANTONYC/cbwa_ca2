#FROM alpine:latest AS builder


# Install all dependencies required for compiling busybox
#RUN apk add gcc musl-dev make perl

# Download busybox sources
#RUN wget https://busybox.net/downloads/busybox-1.35.0.tar.bz2 \
 # && tar xf busybox-1.35.0.tar.bz2 \
 # && mv /busybox-1.35.0 /busybox
  
# Create a non-root user to own the files and run our server
#RUN adduser -D static

# Download CA1 from GitHub
#RUN wget https://github.com/JOSEPHANTONYC/mobdev_ca3/archive/main.tar.gz \
  #&& tar xf main.tar.gz \
 # && rm main.tar.gz \
 # && mv /mobdev_ca3-main /home/static

# Change working directory
#WORKDIR /busybox

# Copy the busybox build config (limited to httpd)
##COPY .config .

# Compile and install busybox
#RUN make && make install

# Switch to the scratch image
#FROM scratch

# Expose container port
#EXPOSE 8080

# Copy user and custom BusyBox version to the scratch image
#COPY --from=builder /etc/passwd /etc/passwd
#COPY --from=builder /busybox/_install/bin/busybox /

# Copying the content of Web CA1 to the scratch image
#COPY --from=builder /home/static /home/static

# Change to static user
#USER static

## Change working directory
#WORKDIR /home/static/mobdev_ca3-main

# httpd.conf 
#COPY httpd.conf .

# Issuing commands to run when container is created
#CMD ["/busybox", "httpd", "-f", "-v", "-p", "8080", "-c", "httpd.conf"]

#FROM node:18.7.0
#WORKDIR /home/static/mobdev_ca3-main
#COPY package.json package.json
#COPY package-lock.json package-lock.json
#RUN npm install
#COPY . .
#CMD [ "node", "server.js" ]

FROM node:13-alpine as build
RUN adduser -D static
RUN wget https://github.com/JOSEPHANTONYC/mobdev_ca3

EXPOSE 8080
USER static
WORKDIR /mobdev_ca3
COPY package*.json /mobdev_ca3
RUN npm install -g ionic
RUN npm install
COPY ./ /mobdev_ca3/
RUN npm run-script build:prod
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /mobdev_ca3-main/www/ /usr/share/nginx/html/

