FROM node:18.20.1-alpine3.19 as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY ./package.json /app/
# COPY ./yarn.lock /app/
RUN yarn install
COPY . /app
RUN yarn build


FROM nginx:1.17.8-alpine
# COPY --from=build /app/build /usr/share/nginx/html
# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the built files from the builder stage
COPY --from=build /app/.next /usr/share/nginx/html

# Copy the Next.js static files (if you have a public directory)
COPY --from=build /app/public /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]