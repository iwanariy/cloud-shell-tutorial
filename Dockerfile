FROM python:2.7-onbuild
# XXX: change port in app.py due to container on GCE restriction
EXPOSE 80
CMD [ "python", "app.py" ]
