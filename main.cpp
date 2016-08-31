#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStringList>
#include <QFont>
#include <qqmlcontext.h>
#include "HighScores/myscore.h"
#include "HighScores/scoremodel.h"
#include "HighScores/mediator.h"
#include "GameLogic/Minesweeper.h"
#include "Sound/soundmanager.h"

int main(int argc, char *argv[])
{
    /*Declarations*/
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    /*Minesweeper Object*/
    Minesweeper *mineField = new Minesweeper();
    engine.rootContext()->setContextProperty("mineField", mineField);
    /*Sounds And Music*/
    //About the music
    SoundManager *musicMngr = new SoundManager();
    musicMngr->initFields(50,true,QUrl("qrc:/Sound/Rob Hubbard - Nemesis The Warlock (Maf464 remix).mp3"));
    musicMngr->playSound();
    engine.rootContext()->setContextProperty("musicMngr",musicMngr);
    //About the sounds of the buttons
    SoundManager *soundMngr = new SoundManager();
    soundMngr->initFields(50,false,QUrl("qrc:/Sound/crash_padle.wav"));
    engine.rootContext()->setContextProperty("soundMngr",soundMngr);
    //About the sounds of the cells
    SoundManager *sound2Mngr = new SoundManager();
    sound2Mngr->initFields(50,false,QUrl("qrc:/Sound/temp.wav"));
    engine.rootContext()->setContextProperty("sound2Mngr",sound2Mngr);
    //About the sounds of the bombs
    SoundManager *sound3Mngr = new SoundManager();
    sound3Mngr->initFields(50,false,QUrl("qrc:/Sound/grenade.mp3"));
    engine.rootContext()->setContextProperty("sound3Mngr",sound3Mngr);
    /*Mediator*/
    Mediator *msg = new Mediator();
    engine.rootContext()->setContextProperty("mediator",msg);
    /*Qml Load*/
    engine.load(QUrl(QStringLiteral("qrc:/GUI/main.qml")));
    /*Setting the default font*/
    QFont appFont = QFont("droid sans");
    app.setFont(appFont);
    /*Run*/
    return app.exec();
}
