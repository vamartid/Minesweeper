#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStringList>
#include <qqmlcontext.h>
#include "HighScores/myscore.h"
#include "HighScores/scoremodel.h"
#include "HighScores/mediator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Mediator *msg = new Mediator();
    engine.rootContext()->setContextProperty("mediator",msg);

    engine.load(QUrl(QStringLiteral("qrc:/GUI/main.qml")));

    return app.exec();
}

