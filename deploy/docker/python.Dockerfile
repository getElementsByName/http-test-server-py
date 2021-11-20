ARG BASE_IMAGE_FULLNAME
FROM ${BASE_IMAGE_FULLNAME} as conda
USER root
ENV LANG=en_US.UTF-8

RUN yum install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    make \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    # echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    # echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

ENV PATH /opt/conda/bin:$PATH

FROM conda as python

ARG PYTHON_VERSION=3.8.5
ARG CONDA_ENV_NAME=py38

ENV PATH /opt/conda/envs/$CONDA_ENV_NAME/bin:$PATH
ENV CONDA_DEFAULT_ENV $CONDA_ENV_NAME

RUN conda create python==${PYTHON_VERSION} -y --name ${CONDA_ENV_NAME} && \
    conda run --name ${CONDA_ENV_NAME} pip install --upgrade pip

