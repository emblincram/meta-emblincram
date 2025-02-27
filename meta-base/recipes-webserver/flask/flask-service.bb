DESCRIPTION = "Flask REST API Service"
LICENSE = "CLOSED"

SRC_URI = "file://flask-app.py \
           file://flask.service"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/opt/flask/
    install -m 0755 ${WORKDIR}/flask-app.py ${D}/opt/flask/flask-app.py

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/flask.service ${D}${systemd_system_unitdir}/flask.service
}

FILES:${PN} = "/opt/flask/flask-app.py ${systemd_system_unitdir}/flask.service"
SYSTEMD_SERVICE:${PN} = "flask.service"
