#include "Sound/soundmanager.h"



using namespace std;

/**
 * constructor of the SoundManager
 * SoundManager is an object that controls
 * the properties and the status of a sound
 */
SoundManager::SoundManager(QObject *parent) : QObject(parent){

}

void SoundManager::initFields(int volume,bool loop,QUrl path) {
    this->musicPlaylist = new QMediaPlaylist();
    this->sound=new QMediaPlayer();

    this->musicPlaylist->addMedia(path);

    this->sound->setPlaylist(musicPlaylist);
    this->sound->setVolume(volume);

    if(loop){
        this->musicPlaylist->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }else{
        this->musicPlaylist->setPlaybackMode(QMediaPlaylist::CurrentItemOnce);
    }
}

void SoundManager::changeLoadedSound(QUrl path) {
    this->musicPlaylist->removeMedia(0);
    this->musicPlaylist->addMedia(path);
}

void SoundManager::playSound(){
    if(sound->state()== QMediaPlayer::PlayingState){
        sound->setPosition(0);
    }else if(sound->state()== QMediaPlayer::StoppedState){
        sound->play();
    }
}

void SoundManager::muteSound(bool status){
    sound->setMuted(status);
}
bool SoundManager::getMuteSound(){
    return sound->isMuted();
}
void SoundManager::setSoundVolume(int newVolumeNumber){
    if(newVolumeNumber==0){
        sound->setMuted(true);
    }else{
        if(sound->isMuted()){
            sound->setMuted(false);
        }
        if(newVolumeNumber!=this->sound->volume()){
           sound->setVolume(newVolumeNumber);
        }
    }
}
