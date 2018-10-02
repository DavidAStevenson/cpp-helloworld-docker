FROM gcc:8.2 as builder
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN g++ -o myapp -static hello.cpp

FROM alpine:latest
COPY --from=builder /usr/src/myapp/myapp /myapp

# Create a non-root user and a group with the same name: "myapp"
#ENV USER_GROUP=myapp
#RUN groupadd -r ${USER_GROUP} && \
#    useradd --no-create-home -g ${USER_GROUP} ${USER_GROUP} 
# From here onwards, any RUN, CMD, or ENTRYPOINT will be run under the following user instead of 'root'
#USER ${USER_GROUP} 

CMD ["./myapp"]