FROM node:16-alpine3.11 as build
WORKDIR /home/app
COPY . .
RUN npm install

FROM node:16-alpine3.11
WORKDIR /home/app
COPY --from=build /home/app /home/app
EXPOSE 3000
CMD ["npm","start"]
