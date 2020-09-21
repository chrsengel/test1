FROM nvidia/cuda
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN apt-get update && yes|apt-get upgrade
RUN apt-get install -y nano \
  wget curl build-essential software-properties-common git bash \
  libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh -O anaconda.sh
RUN bash anaconda.sh -b
RUN rm anaconda.sh
ENV PATH /root/anaconda3/bin:$PATH
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# config jupyter, set "root" as password
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# install fast ai
RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

# jupyter port
EXPOSE 8888

# run as main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]

# conda init
#RUN conda update -n base -c defaults conda
#RUN conda init sh

# conda environments
# stylegan2
#RUN conda create --name sg2 python=3.6 && conda activate sg2
#RUN conda install conda-forge tensorflow-gpu=1.16 opencv jupyterlab pillow requests

# fastai
#RUN conda create --name ai python=3.8 && conda activate ai
#RUN conda install torchvision cudatoolkit=10.1 opencv jupyterlab pillow requests
#RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

#RUN conda install torchvision opencv pillow requests
#RUN conda install -c conda-forge jupyterlab
#RUN conda install -c fastai -c pytorch -c anaconda fastai gh anaconda

#COPY conda.sh /tmp/conda.sh
#RUN chmod +x /tmp/conda.sh
#RUN /tmp/conda.sh

#RUN git clone https://github.com/NVlabs/stylegan2.git

# run jupyter lab
#CMD jupyer lab --ip 0.0.0.0 --no-browser --allow-root
#EXPOSE 8888
