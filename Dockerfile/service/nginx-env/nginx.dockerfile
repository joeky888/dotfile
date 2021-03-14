FROM nginx:stable-alpine
COPY ./dist /usr/share/nginx/html
COPY entrypoint.sh /

CMD [ "/entrypoint.sh" ]