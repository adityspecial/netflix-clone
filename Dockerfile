# Stage 1: Build stage
FROM nginx:alpine as builder

COPY index.html /usr/share/nginx/html/index.html

# Copy the nginx binary
RUN cp /usr/sbin/nginx /nginx

# Stage 2: Distroless stage
FROM gcr.io/distroless/static-debian11

COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html
COPY --from=builder /nginx /usr/sbin/nginx
COPY --from=builder /etc/nginx /etc/nginx

EXPOSE 3000

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
