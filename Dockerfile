FROM pytorch/pytorch
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y nano \
  wget curl build-essential software-properties-common git bash

# install fast ai
RUN conda update -n base conda
RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda
RUN pip install fastbook
