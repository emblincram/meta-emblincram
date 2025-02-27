FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://dnsmasq.conf \
            file://dnsmasq.service"

do_install:append () {
    # Installiere die Konfigurationsdatei
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dnsmasq.conf ${D}${sysconfdir}/dnsmasq.conf

    # Installiere die Systemd-Service-Datei
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/dnsmasq.service ${D}${systemd_system_unitdir}/dnsmasq.service
}

# Systemd-Integration sicherstellen
SYSTEMD_SERVICE:${PN} = "dnsmasq.service"

