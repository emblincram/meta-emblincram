SUMMARY = "ttyd Systemd Service"
DESCRIPTION = "Startet ttyd automatisch beim Booten"

LICENSE = "MIT"
# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://ttyd.service"

S = "${WORKDIR}"

#DEPENDS = "libwebsockets zlib"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/ttyd ${D}${bindir}/ttyd

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ttyd.service ${D}${systemd_system_unitdir}/ttyd.service
}

FILES:${PN} += "${bindir}/ttyd"
FILES:${PN} += "${systemd_system_unitdir}/ttyd.service"

inherit systemd

SYSTEMD_SERVICE:${PN} = "ttyd.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
