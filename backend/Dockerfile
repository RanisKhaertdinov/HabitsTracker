FROM sbtscala/scala-sbt:eclipse-temurin-alpine-24.0.1_9_1.11.7_3.7.4

WORKDIR /app

COPY . .

RUN apk add --no-cache bash curl

RUN sbt update
RUN sbt compile

CMD ["sbt", "run"]