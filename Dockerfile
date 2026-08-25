# Build stage
FROM node:24-bookworm-slim AS builder

WORKDIR /app

COPY ./app/package*.json ./

RUN npm ci

COPY ./app/ .


# Runtime stage
FROM node:24-bookworm-slim

WORKDIR /app

COPY --from=builder /app ./

RUN rm -rf /usr/local/lib/node_modules/npm

EXPOSE 8000

CMD ["node", "app.js"]