FROM alpine:latest
RUN apk update
RUN apk add openssh nano bash
RUN echo "PasswordAuthentication no" > /etc/ssh/ssh_config.d/passwordless
COPY motd /etc/motd
RUN ssh-keygen -A
COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
