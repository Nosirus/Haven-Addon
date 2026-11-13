ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL io.hass.version=${BUILD_VERSION}
LABEL io.hass.type=addon
LABEL io.hass.arch=${BUILD_ARCH}

ENV NODE_ENV=production
ENV HAVEN_DATA_DIR=/config/addons_config/haven

RUN sed -i 's#DATA="/data"#DATA="${HAVEN_DATA_DIR:-/data}"#' /entrypoint.sh \
 && grep -q 'HAVEN_DATA_DIR' /entrypoint.sh

COPY ha-options.sh /ha-options.sh
RUN chmod +x /ha-options.sh

RUN sed -i '/^exec .*node/i. /ha-options.sh' /entrypoint.sh \
 && grep -q '^\. /ha-options\.sh' /entrypoint.sh

RUN sed -i "s#const lan = lanAddress();#const lan = (process.env.HAVEN_RELAY_LAN_IP || '').trim() || lanAddress();#" /app/src/voiceRelay/mediasoup.js \
 && sed -i "s#const listenIp = lan || '0.0.0.0';#const listenIp = '0.0.0.0';#" /app/src/voiceRelay/mediasoup.js \
 && grep -q 'HAVEN_RELAY_LAN_IP' /app/src/voiceRelay/mediasoup.js \
 && grep -q "const listenIp = '0.0.0.0';" /app/src/voiceRelay/mediasoup.js

COPY catppuccin-mocha-maroon.theme.css /app/themes/
RUN chown node:node /app/themes/catppuccin-mocha-maroon.theme.css

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]
