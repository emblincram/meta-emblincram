# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

SUMMARY = "Simple Distributet Application Example"
DESCRIPTION = "First test with embedded applications on multiple modules"

LICENSE = "MIT"
# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("Simple Distributed Application Example");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

SRC_URI = "git://github.com/emblincram/distrap.git;branch=main;protocol=ssh"
#SRC_URI = "git:///mnt/ssd/work/distrap;branch=main;protocol=file"

SRCREV = "1f5b34a43a77f1c2adc4d4853889d0a8ffe5ccc9"

S = "${WORKDIR}/git"

DEPENDS = "cmake"

inherit cmake

do_install() {
    #oe_runmake install DESTDIR=${D}
    cmake --install ${B} --prefix=${D}/usr
}
