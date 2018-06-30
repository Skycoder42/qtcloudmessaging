TARGET = QtCloudMessagingEmbeddedKaltiot
QT = core cloudmessaging

# Check for KALTIOT_SDK environment
ENV_KALTIOT_SDK = $$(KALTIOT_SDK)

# Or define KALTIOT_SDK path here
KALTIOT_SDK =

isEmpty(ENV_KALTIOT_SDK) {
	isEmpty(KALTIOT_SDK) {
		android: KALTIOT_SDK = $$PWD/../../../qt-builds/rasp-pi/kaltiot/qtiot.hbrs.kaltiot_Android_SDK_1.3.14
		else:linux:equals(QT_ARCH, arm): KALTIOT_SDK = $$PWD/../../../qt-builds/rasp-pi/kaltiot/qtiot.hbrs.kaltiot_RaspberryPi_SDK_1.3.16
		else:linux: KALTIOT_SDK = $$PWD/../../../qt-builds/rasp-pi/kaltiot/qtiot.hbrs.kaltiot_Linux64_SDK_1.3.16
		else:error(Platform not supported)
		message(KALTIOT_SDK = $$KALTIOT_SDK)
	}
} else: KALTIOT_SDK = $$ENV_KALTIOT_SDK

INCLUDEPATH += $$KALTIOT_SDK
INCLUDEPATH += $$KALTIOT_SDK/src

HEADERS += \
	qcloudmessagingembeddedkaltiotclient.h \
	qcloudmessagingembeddedkaltiotprovider.h \
	qcloudmessagingembeddedkaltiotclient_p.h \
	qcloudmessagingembeddedkaltiotprovider_p.h \
	qcloudmessagingembeddedkaltiotrest.h

SOURCES += \
	qcloudmessagingembeddedkaltiotclient.cpp \
	qcloudmessagingembeddedkaltiotprovider.cpp \
	qcloudmessagingembeddedkaltiotrest.cpp

android {
	DEFINES += ANDROID_OS
	QT += androidextras
	HEADERS += \
		 $$PWD/android/ks_gw_client_android.h
} else {

	DEFINES += EMBEDDED_AND_DESKTOP_OS
	system(ln -s $$shell_quote($$KALTIOT_SDK/src/ks_gw_client.h) $$shell_quote($$PWD/ks_gw_client.h))
	HEADERS += \
		 $$KALTIOT_SDK/src/ks_gw_client.h

	LIBS += $$KALTIOT_SDK/libks_gw_client.a
}

load(qt_module)

DISTFILES += \
	README.md
