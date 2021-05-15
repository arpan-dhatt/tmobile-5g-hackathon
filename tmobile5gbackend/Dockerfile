FROM public.ecr.aws/lambda/python:3.7
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8


WORKDIR /
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install opencv-python
WORKDIR /
COPY docker /app
WORKDIR /

WORKDIR /

CMD supervisord -c /etc/supervisor/supervisord.conf
