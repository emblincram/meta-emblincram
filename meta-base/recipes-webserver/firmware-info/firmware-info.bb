SUMMARY = "Firmware-Info Webseite"

# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r1"

SRC_URI = "file://firmware-info.html;subdir=${PN}"

do_install() {
    install -d \${D}/opt/flask/templates/
    install -m 0644 \${WORKDIR}/firmware-info.html \${D}/opt/flask/templates/index.html
}

FILES:${PN} = "/opt/flask/templates/index.html"

