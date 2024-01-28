FROM alpine:latest
RUN apk update
RUN apk add openssh
#RUN rc-update add sshd
#RUN rc-update sshd start
RUN ssh-keygen -A
COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
