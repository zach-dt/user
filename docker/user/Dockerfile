FROM ubuntu:16.04

ENV	SERVICE_USER=myuser \
	SERVICE_UID=10001 \
	SERVICE_GROUP=mygroup \
	SERVICE_GID=10001

RUN addgroup --gid ${SERVICE_GID} ${SERVICE_GROUP} && adduser --ingroup ${SERVICE_GROUP} --shell /sbin/nologin --uid ${SERVICE_UID} ${SERVICE_USER}

RUN apt-get update
RUN apt-get install -y ca-certificates

# Install GO
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
RUN mkdir /go && curl https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz | tar xvzf - -C /go --strip-components=1
RUN mkdir /gopath

ENV GOROOT /go
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Build app
COPY . /go/src/github.com/microservices-demo/user/
WORKDIR /go/src/github.com/microservices-demo/user/

RUN go get -v github.com/Masterminds/glide 
RUN glide install && go build -a -ldflags -linkmode=external -installsuffix cgo -o /user main.go

ENV HATEAOS user
ENV USER_DATABASE mongodb
ENV MONGO_DATABASE default
# ENV MONGO_URI mongodb://user-db-user:user-db4SockShop@user-db-shard-00-00-vvczq.mongodb.net:27017,user-db-shard-00-01-vvczq.mongodb.net:27017,user-db-shard-00-02-vvczq.mongodb.net:27017/test?ssl=true&replicaSet=user-db-shard-0&authSource=admin
ENV MONGO_URI mongodb://user-db-svc:27017
ENV PORT 8080

WORKDIR /
EXPOSE 8080

RUN	chmod +x /user && \
	chown -R ${SERVICE_USER}:${SERVICE_GROUP} /user && \
	setcap 'cap_net_bind_service=+ep' /user

USER ${SERVICE_USER}

CMD ["/user", "-port=8080"]