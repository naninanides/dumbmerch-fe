FROM node:16-alpine3.11 as production
WORKDIR /home/app
COPY . .
RUN npm install
RUN npm run build

FROM node:16-alpine3.11
WORKDIR /home/app
COPY --from=production /home/app /home/app
RUN npm install -g server
EXPOSE 3000
CMD ["npx","serve","build","-l","3000"]
