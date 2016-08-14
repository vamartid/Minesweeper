#ifndef SOUNDMANAGER_H
#define SOUNDMANAGER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include  <iostream>

class SoundManager: public QObject
{

    QMediaPlaylist *musicPlaylist;
    QMediaPlayer * sound;
    Q_OBJECT
public:
    explicit SoundManager(QObject *parent = 0);
public slots:
    void initFields(int ,bool ,QUrl );
    void changeLoadedSound(QUrl);
    void playSound();
    void muteSound(bool);
    void setSoundVolume(int);
    bool getMuteSound();
};

#endif // SOUNDMANAGER_H
