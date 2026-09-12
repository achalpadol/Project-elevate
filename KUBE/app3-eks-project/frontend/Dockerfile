FROM node:lts AS build
 
WORKDIR /code
 
COPY package.json package-lock.json ./
COPY .npmrc ./
COPY .yarnrc.yml ./
 
RUN npm ci
 
COPY . .
 
RUN npm run build
 
 
FROM nginx:1.13-alpine
 
COPY --from=build /code/build /usr/share/nginx/html
 
EXPOSE 80
 
CMD ["nginx", "-g", "daemon off;"]
