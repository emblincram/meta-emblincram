# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

SUMMARY = "Standalone C++ Anwendung für Yocto"
DESCRIPTION = "Ein extern entwickeltes C++-Programm, das mit CMake gebaut wird"

LICENSE = "MIT"
# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("Example recipe created by bitbake-layers");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

# Hier wird das externe Repository eingebunden
SRC_URI = "git://github.com/emblincram/helloly.git;branch=main;protocol=ssh"

SRCREV = "7d50bede0b0d7c997d41e1bf26711e0f725e52ab"

S = "${WORKDIR}/git"

DEPENDS = "cmake"

inherit cmake

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/helloly ${D}${bindir}/helloly
}
