TEMPLATE = subdirs
SUBDIRS = cloudmessaging

embedded-kaltiot: SUBDIRS += cloudmessagingembeddedkaltiot
firebase: SUBDIRS += cloudmessagingfirebase

cloudmessagingembeddedkaltiot.depends += cloudmessaging
cloudmessagingfirebase.depends += cloudmessaging

DISTFILES += \
	../README.md
