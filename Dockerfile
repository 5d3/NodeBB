# The base image is the latest 8.x node (LTS)
FROM node:8.15.1@sha256:fb8e07b6612416517560d1f3ddc1a01c1dc263620956b6a348aeb1289ad141dd

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY install/package.json /usr/src/app/package.json
RUN npm install && npm cache clean --force
COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

CMD ./nodebb start

# the default port for NodeBB is exposed outside the container
EXPOSE 4567