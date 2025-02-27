# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

SUMMARY = "data streaming application"
DESCRIPTION = "Standalone C++ Data Storage/Streaming Application for Yocto"

LICENSE = "MIT"
# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain(" Data store and streaming application");
    bb.plain("***********************************************");
}
addtask display_banner before do_build

# Hier wird das externe Repository eingebunden
SRC_URI = "git://github.com/emblincram/streamer.git;branch=main;protocol=ssh"
#SRC_URI = "git:///mnt/ssd/work/streamer;branch=main;protocol=file"

SRC_URI += "file://streamer.service"
SRCREV = "e26cac30b3dda437593089ca81e2e12e5ac89d58"

PV = "1.0"

DEPENDS = "cmake libwebsockets pkgconfig-native jsoncpp"

S = "${WORKDIR}/git"

inherit cmake systemd

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/streamer ${D}${bindir}/streamer

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/streamer.service ${D}${systemd_system_unitdir}
}

FILES:${PN} = "${bindir}/streamer"
SYSTEMD_SERVICE:${PN} = "streamer.service"
