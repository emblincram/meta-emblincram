# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

SUMMARY = "A systemd service that prints the time every second"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://print_time.sh \
    file://print_time.service \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/print_time.sh ${D}${bindir}/print_time.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/print_time.service ${D}${systemd_system_unitdir}/print_time.service
}

FILES:${PN} += " \
    ${bindir}/print_time.sh \
    ${systemd_system_unitdir}/print_time.service \
"

SYSTEMD_SERVICE:${PN} = "print_time.service"

