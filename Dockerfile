FROM python:3.5-slim

EXPOSE 8080

#Install Workspace for Python 

RUN apt-get update \
    && apt-get install --assume-yes build-essential git curl 

RUN apt-get install --assume-yes npm

RUN npm install -g yarn

RUN mkdir -p /var/theia

WORKDIR /var/theia

ADD ./theia/package.json .

RUN yarn 

RUN yarn theia build

RUN mkdir -p /var/app

WORKDIR /var/app

ADD requirements.txt /var/app

RUN pip install -r requirements.txt

ADD . .

RUN python manage.py migrate

CMD python manage.py runserver 0.0.0.0:8080