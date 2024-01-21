FROM alpine
RUN apk update
RUN apk add bash curl
WORKDIR /app
COPY . .
RUN chmod +x update-ip.sh 
RUN crontab jobs
CMD /app/update-ip.sh && crond -f -d 0
