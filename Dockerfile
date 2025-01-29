FROM python:3.10.8-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git -y
COPY requirements.txt /requirements.txt

RUN pip3 install -U pip --root-user-action=ignore && pip3 install -U -r /requirements.txt --root-user-action=ignore
RUN mkdir /Deendayal_botz
WORKDIR /Deendayal_botz
COPY start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]



