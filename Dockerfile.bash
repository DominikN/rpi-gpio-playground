# docker compose -f compose.bash.yaml up

FROM ubuntu:20.04

COPY gpio-test.sh .

CMD ["./gpio-test.sh"]