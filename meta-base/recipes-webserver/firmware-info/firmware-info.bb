SUMMARY = "Firmware-Info Webseite"

# bitbake -e | grep ^COMMON_LICENSE_DIR
# md5sum LICENSE
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r1"

SRC_URI = "file://firmware-info.template.html"

do_install() {
    #install -d ${D}/opt/flask/templates/
    #install -m 0644 ${WORKDIR}/firmware-info.html ${D}/opt/flask/templates/index.html
    #install -m 0644 ${WORKDIR}/firmware-info.html ${D}/var/www/html/index.html

    # HTML-Datei mit Build-Informationen generieren
    install -d ${D}/var/www/html/ 
    
    sed -e "s|@BUILD_TIME@|$(date)|g" \
        -e "s|@YOCTO_VERSION@|${DISTRO_VERSION}|g" \
        -e "s|@BUILD_HOST@|${BUILD_SYS}|g" \
        -e "s|@KERNEL_VERSION@|$(uname -r)|g" \
        -e "s|@GIT_COMMIT@|$(cd ${S} && git rev-parse --short HEAD 2>/dev/null || echo 'unknown')|g" \
        ${WORKDIR}/firmware-info.template.html > ${D}/var/www/html/index.html
}

#FILES:${PN} = "/opt/flask/templates/index.html"
FILES:${PN} = "/var/www/html/index.html"

