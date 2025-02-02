
FROM python:3.10.8
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /Deendayal_botz
COPY . /Deendayal_botz/

RUN chmod +x /Deendayal_botz/start.sh

RUN pip3 install --no-cache-dir -U pip --root-user-action=ignore && \
    pip3 install --no-cache-dir -U -r requirements.txt --root-user-action=ignore

CMD ["/bin/bash", "./start.sh"]


