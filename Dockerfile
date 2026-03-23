# ---------- Build stage ----------
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build


# ---------- Run stage ----------
FROM node:20-alpine

WORKDIR /app

# install serve globally
RUN npm install -g serve

# copy dist from builder
COPY --from=builder /app/dist ./dist

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]