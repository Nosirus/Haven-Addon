FROM ghcr.io/ancsemi/haven:latest

ENV NODE_ENV=production
ENV HAVEN_DATA_DIR=/config/addons_config/haven

RUN sed -i 's#DATA="/data"#DATA="${HAVEN_DATA_DIR:-/data}"#' /entrypoint.sh
COPY catppuccin-mocha-maroon.theme.css /app/themes/
RUN chown node:node /app/themes/catppuccin-mocha-maroon.theme.css
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
