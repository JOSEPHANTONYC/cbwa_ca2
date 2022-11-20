##Creating Dockerfile
      go to github and create a new repository with name cbwa_ca2 
      Create a file named Dockerfile
##Open Dockerfile
Put the following in Dockerfile :

FROM node:19-alpine as build

WORKDIR /app

RUN wget https://github.com/josephantonyc/mobdev_ca3/archive/main.tar.gz && tar xf main.tar.gz && rm main.tar.gz
 

WORKDIR /app/mobdev_ca3-main/

RUN npm install -g ionic
RUN npm install

RUN npm run-script build --prod

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/

EXPOSE 80

Before you run it, let’s understand line by line that what we are actually doing in our Dockerfile.
#FROM node:19-alpine as build
In the first line, we are telling Docker to use node19 alpine from dockerhub to use as a base image which will allow us to run the commands related to npm. Also, we are telling to give it a short name build which we can refer in our file further.

#WORKDIR /app
In the above lines, we are creating a working directory by name of app and copying package and package-lock.json to app folder.

#RUN npm install -g ionic
#RUN npm install
For ionic to run, we have to install ionic globally and then we are running npm install to install all the project dependencies.

#RUN npm run-script build:prod
The above command runs our custom script which is simply translation of ng build –prod. It creates a www folder of our project, which we will be using to deploy to nginx.

#FROM nginx:alpine
#RUN rm -rf /usr/share/nginx/html/*
#COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/
In the above lines, we are first telling Docker to use the nginx from dockerhub. After that we are removing everything present in /usr/share/nginx/html folder and eventually copying everything from www folder to the html folder.

#EXPOSE 80
I am using this port to show my app in the web but we can use another one like 8080, etc.

#mobdev_ca3-main
we are running this app in the docker.

Now, when we have knowledge of what is happening in our Dockerfile, let’s move on to the part where we run our commands.

we need to download our files from github in the desktop and then we can follow the next steps.

##Build and Deploy using Dockerfile
#To build a Docker Image, we have to run the following command in our terminal:
docker build -t myapp .

#To run the built docker image, use the following command:
docker run -it --rm -p 80:80 myapp 

Finally we go to localhost80 in the web and we can see our app.



I used some reference to do my project like:
https://blog.knoldus.com/deployment-with-docker-in-ionic/
https://www.docker.com/blog/how-to-setup-your-local-node-js-development-environment-using-docker/
https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/


Website traffic refers to web users who visit a website. Web traffic is measured in visits, sometimes called "sessions," and is a common way to measure an online business effectiveness at attracting an audience. 

the best cloud providers:
1-Amazon Web Services (AWS)
2-Microsoft Azure
3-Google Cloud Platform (GCP)
4-Alibaba Cloud
5-Oracle Cloud
6-IBM Cloud (Kyndryl)
7-Tencent Cloud
8-OVHcloud
9-DigitalOcean
10-Linode (Akamai)
11-A2Hosting

In my opinion  A2Hosting claims to be the fastest, easiest, and most reliable dedicated Docker hosting solution .Because we just have  10-50 users generating traffic monthly. so it is better and cheaper but if we would like to have more market , service, database and others , Amazon is better because we have more zones but it is more expensive.

reference:
https://dgtlinfra.com/top-10-cloud-service-providers-2022/#:~:text=Top%2010%20Cloud%20Service%20Providers%201%201.%20Amazon,7.%20Tencent%20Cloud%208%208.%20OVHcloud%20More%20items

https://alterwebhost.com/cheap-docker-hosting/

https://www.bigcommerce.com/ecommerce-answers/what-is-website-traffic-and-how-to-interpret-it/
