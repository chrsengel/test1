FROM pytorch/pytorch:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nano \
  wget curl build-essential software-properties-common git bash

# conda init
RUN conda update -n base -c defaults conda
#RUN conda init sh

# conda environments
# stylegan2
#RUN conda create --name sg2 python=3.6 && conda activate sg2
#RUN conda install conda-forge tensorflow-gpu=1.16 opencv jupyterlab pillow requests

# fastai
#RUN conda create --name ai python=3.8 && conda activate ai
#RUN conda install torchvision cudatoolkit=10.1 opencv jupyterlab pillow requests
#RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

RUN conda install torchvision opencv pillow requests
RUN conda install -c conda-forge jupyterlab
RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

#COPY conda.sh /tmp/conda.sh
#RUN chmod +x /tmp/conda.sh
#RUN /tmp/conda.sh

#RUN git clone https://github.com/NVlabs/stylegan2.git

# run jupyter lab
CMD jupyer lab --ip 0.0.0.0 --no-browser --allow-root
EXPOSE 8888
