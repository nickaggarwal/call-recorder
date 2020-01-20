FROM python:3.5-slim

EXPOSE 8080

# Install Workspace for Python 

RUN apt-get update \
    && apt-get install --assume-yes build-essential git curl 

RUN apt-get install --assume-yes npm

RUN npm install -g yarn

RUN mkdir -p /var/theia

WORKDIR /var/theia

RUN wget https://codejudge-theia.s3.amazonaws.com/Archive.zip

RUN unzip Archive.zip

RUM rm Archive.zip

# End Install for Workspace 

RUN mkdir -p /var/app

WORKDIR /var/app

ADD requirements.txt /var/app

RUN pip install -r requirements.txt

ADD . .

RUN python manage.py migrate

WORKDIR /var/theia

CMD yarn theia start --hostname 0.0.0.0 --port 3005