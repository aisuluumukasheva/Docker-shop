FROM ubuntu

WORKDIR /

COPY . .

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt install -y python3-pip 
RUN pip install --upgrade pip
RUN pip install wheel gunicorn
RUN pip install -r req.txt

ENV SECRET_KEY=co1^n726)f5s6kvln4v-&z)6ytis8&j3frvf3a@7y%*k6pzy(+
ENV DEBUG=1
ENV DB_USER=postgres
ENV DB_PASSWORD=//postgres:7pxbfJg2qGYUOyMn6Jc7
ENV DB_HOST=containers-us-west-25.railway.app
ENV DB_PORT=6917
ENV DB_NAME=railway
ENV ALLOWED_HOSTS=127.0.0.1,
ENV PORT=8000

RUN python3 manage.py migrate
RUN python3 manage.py collectstatic

CMD gunicorn --bind 0.0.0.0:$PORT config.wsgi:application
