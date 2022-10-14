
FROM public.ecr.aws/docker/library/python:3.7

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

COPY ./app /app

EXPOSE 80

CMD gunicorn --bind 0.0.0.0:80 main:app