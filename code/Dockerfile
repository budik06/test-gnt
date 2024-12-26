FROM genotek/r-base

RUN apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,cache,log}/

WORKDIR /app

COPY keyrings/*.gpg /usr/share/keyrings/
COPY script* /app/
COPY apt/sources.list.d/debian.sources /etc/apt/sources.list.d/

RUN chmod +x /app/script.sh && rm /etc/apt/sources.list.d/debian-unstable.list && rm /etc/apt/sources.list

CMD ["/usr/bin/python3", "/app/script_run.py"]