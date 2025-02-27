SUMMARY = "USB Gadget setup service for BeagleBone"
DESCRIPTION = "Sets up usb0 network interface for use with dnsmasq"

# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://usb-gadget.service \
           file://usb-gadget-setup.sh"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "usb-gadget.service"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/usb-gadget.service ${D}${systemd_system_unitdir}/usb-gadget.service

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/usb-gadget-setup.sh ${D}${bindir}/usb-gadget-setup.sh
}

FILES:${PN} += "${systemd_system_unitdir}/usb-gadget.service ${bindir}/usb-gadget-setup.sh"
