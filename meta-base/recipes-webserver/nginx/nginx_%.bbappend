FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://nginx.conf \
            file://nginx.service"

do_install:append () {
    # Installiere die NGINX-Konfigurationsdatei
    install -d ${D}/etc/nginx/
    install -m 0644 ${WORKDIR}/nginx.conf ${D}/etc/nginx/nginx.conf

    # Installiere die Systemd-Service-Datei
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/nginx.service ${D}${systemd_system_unitdir}/nginx.service
}

# Systemd-Integration sicherstellen
SYSTEMD_SERVICE:${PN} = "nginx.service"

#FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
# PACKAGECONFIG:append = " http proxy ssl websocket gzip"
#PACKAGECONFIG:append = " http proxy websocket"
