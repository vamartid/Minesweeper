TEMPLATE = app

QT += qml quick \
        multimedia \
        multimediawidgets
CONFIG += c++11

SOURCES += main.cpp \
    GameLogic/Cell.cpp \
    GameLogic/Minesweeper.cpp \
    HighScores/mediator.cpp \
    HighScores/myscore.cpp \
    HighScores/scoremodel.cpp \
    Sound/soundmanager.cpp

RESOURCES += qml.qrc

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

DISTFILES +=
