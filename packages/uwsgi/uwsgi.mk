UWSGI_VERSION = 1.9.14
UWSGI_SOURCE = uwsgi-$(UWSGI_VERSION).tar.gz
UWSGI_SITE = http://projects.unbit.it/downloads
UWSGI_LICENSE = GPL2
UWSGI_LICENSE_FILES = LICENSE

define UWSGI_BUILD_CMDS
    (cd $(@D); PATH="$(HOST_DIR)/usr/x86_64-buildroot-linux-gnu/sysroot/usr/bin:$(PATH)" UWSGI_INCLUDES="$(TARGET_INCLUDES)" CC="$(TARGET_CC)" CPP="$(TARGET_CPP)" $(HOST_DIR)/usr/bin/python uwsgiconfig.py --build)
endef

define UWSGI_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/uwsgi $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
