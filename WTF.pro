TEMPLATE = app

QT += qml quick widgets sql

SOURCES += main.cpp \
    gamelogic.cpp \
    selectplayer.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    gamelogic.h \
    selectplayer.h

OTHER_FILES += \
    android/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

FORMS += \
    form.ui

