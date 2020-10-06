FROM thomasweise/docker-texlive-full

RUN apt-get update && apt-get install biber -y

LABEL vendor=Open-source \
      com.github.marcellodesales.is-beta=false \
      com.github.marcellodesales.is-production=true \
      com.github.marcellodesales.version="1.0.0" \
      com.github.marcellodesales.release-date="2020-10-05" \
      com.github.marcellodesales.description="For liantze/AltaCV resumes"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/bash", "/entrypoint.sh"]
