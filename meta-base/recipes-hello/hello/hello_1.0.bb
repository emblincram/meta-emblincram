# SPDX-License-Identifier: MIT
# SPDX-Author: Roman Koch <koch.romam@gmail.com>
# SPDX-Copyright: 2024 Roman Koch <koch.romam@gmail.com>

SUMMARY = "Hello World application"
DESCRIPTION = "A simple Hello World application written in C"

LICENSE = "MIT"
# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://hello.c"

DEPENDS = ""

S = "${WORKDIR}"

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("*  Example recipe created by bitbake-layers   *");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} -o hello hello.c
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 hello ${D}${bindir}/hello
}
