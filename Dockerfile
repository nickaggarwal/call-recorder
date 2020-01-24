FROM python:3.5-slim

EXPOSE 8080

ARG workspace="none"

RUN apt-get update \
    && apt-get install --assume-yes wget

# Install Workspace for Python 

RUN if [ $workspace = "theia" ] ; then \
	wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/theia/pre-build.sh \
    && chmod 775 ./pre-build.sh && sh pre-build.sh ; fi

RUN mkdir -p /var/theia 

WORKDIR /var/theia

RUN if [ $workspace = "theia" ] ; then \
	wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/theia/python/package.json \
	&& chmod 775 ./package.json ; fi


RUN if [ $workspace = "theia" ] ; then \
	wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/theia/build.sh \
    && chmod 775 ./build.sh && sh build.sh ; fi

# End Install for Workspace 

RUN mkdir -p /var/app

WORKDIR /var/app

ADD requirements.txt /var/app

# Build the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/python/build.sh
RUN chmod 775 ./build.sh
RUN sh build.sh

ADD . .

# Run the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/python/run.sh
RUN chmod 775 ./run.sh
CMD sh run.sh