TARGET  = Minesweeper
TEMPLATE = app

QT += qml quick \
        multimedia \
        multimediawidgets

CONFIG += static

SOURCES += main.cpp \
    GameLogic/Cell.cpp \
    GameLogic/Minesweeper.cpp \
    HighScores/mediator.cpp \
    HighScores/myscore.cpp \
    HighScores/scoremodel.cpp \
    Sound/soundmanager.cpp

RESOURCES += \
    qml.qrc

#Windows icon
#Not working...we need to fix this
#win32:RC_ICONS += :/GUI/icons/ico/minesweeper.ico

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    GameLogic/Cell.h \
    GameLogic/Minesweeper.h \
    HighScores/mediator.h \
    HighScores/myscore.h \
    HighScores/scoremodel.h \
    Sound/soundmanager.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
