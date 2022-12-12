# build image
FROM golang:1.19.4-alpine3.17 as builder
RUN apk update && apk add git ca-certificates make curl aws-cli
RUN curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.13/2022-10-31/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN cp kubectl /usr/bin/

WORKDIR /app
COPY . .
RUN make build
RUN cp eks-node-viewer /usr/bin/
CMD ["eks-node-viewer"]