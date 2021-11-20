ARG BASE_IMAGE_FULLNAME
FROM ${BASE_IMAGE_FULLNAME} as python

COPY ./requirements.txt /workspace/http_test_server/requirements.txt
RUN pip3 install -r /workspace/http_test_server/requirements.txt

COPY ./ /workspace/http_test_server
WORKDIR /workspace/http_test_server