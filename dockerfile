FROM centos:latest

RUN dnf install epel-release
RUN dnf install python3-pip python3-devel gcc -y

WORKDIR /opt/minitower

COPY ./dockerfiles/requirement.txt ./

RUN pip3 install -r requirement.txt

RUN django-admin startproject minitower /opt/minitower

RUN python3 manage.py makemigrations

RUN python3 manage.py migrate

RUN python3 manage.py startapp inventory

COPY ./project/settings.py ./minitower/settings.py
COPY ./project/urls.py ./minitower/urls.py
COPY ./static/main.css ./static/main/css/main.css
COPY ./templates/base.html ./templates/base.html

COPY ./app ./inventory/

EXPOSE 8000

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]
