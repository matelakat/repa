UWSGI_VERSION = python-config-fix
UWSGI_SITE = git://github.com/matelakat/uwsgi
UWSGI_LICENSE = GPL2
UWSGI_LICENSE_FILES = LICENSE

define UWSGI_BUILD_CMDS
    (cd $(@D) && \
    UWSGICONFIG_PYTHONCONFIG=$(@D)/buildroot-python-config \
    PYTHON_VERSION_MAJOR=$(PYTHON_VERSION_MAJOR) \
    BUILD_DIR=$(BUILD_DIR) \
    PYTHON_VERSION=$(PYTHON_VERSION) \
    UWSGI_PYTHON_NOLIB="True" \
    PATH="$(BUILD_DIR)/pcre-8.32:$(BUILD_DIR)/libxml2-2.9.0:${PATH}" \
    UWSGI_INCLUDES="$(TARGET_INCLUDES)" \
    CC="$(TARGET_CC)" \
    CPP="$(TARGET_CPP)" \
    $(HOST_DIR)/usr/bin/python uwsgiconfig.py --build)
endef

define UWSGI_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/uwsgi $(TARGET_DIR)/usr/bin
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/var/uwsgi
endef

define UWSGI_USERS
    uwsgi -1 uwsgi -1 * /var/uwsgi - - Daemon for running uwsgi processes
endef

$(eval $(generic-package))
