ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL io.hass.version=${BUILD_VERSION}
LABEL io.hass.type=addon
LABEL io.hass.arch=${BUILD_ARCH}

ENV NODE_ENV=production
ENV HAVEN_DATA_DIR=/config/addons_config/haven

RUN sed -i 's#DATA="/data"#DATA="${HAVEN_DATA_DIR:-/data}"#' /entrypoint.sh

COPY catppuccin-mocha-maroon.theme.css /app/themes/
RUN chown node:node /app/themes/catppuccin-mocha-maroon.theme.css

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
