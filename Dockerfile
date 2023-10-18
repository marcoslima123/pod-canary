FROM node:latest

ARG NEXT_PUBLIC_STATIC_VERSION
ENV NEXT_PUBLIC_STATIC_VERSION=$NEXT_PUBLIC_STATIC_VERSION

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN chmod +x postbuild.sh

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]