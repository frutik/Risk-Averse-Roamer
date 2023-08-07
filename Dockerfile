FROM python:3.10 as app

WORKDIR app

ENV TMP_DIR=/tmp/app

RUN mkdir ${TMP_DIR} -p && \
    chmod 0777 ${TMP_DIR} -R

CMD ["uwsgi"]

VOLUME [ "${TMP_DIR}" ]

# RUN pip install --only-binary ":all:" grpcio

COPY ./requirements.txt ./
RUN pip install -r requirements.txt

COPY . ./

RUN ./manage.py collectstatic --noinput

RUN chown -R www-data:www-data .

ENV TZ=Europe/Amsterdam
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER www-data:www-data

FROM nginx:mainline-alpine as web

RUN apk add --no-cache tzdata
ENV TZ Europe/Amsterdam

COPY --from=app /app/static /usr/share/nginx/html/static
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
