#include "mediator.h"
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>
#include<iostream>
using namespace std;
Mediator::Mediator(QObject *parent) : QObject(parent)
{
    _scoreModel1 = new scoreModel();
    _scoreModel2 = new scoreModel();
    _scoreModel3 = new scoreModel();

    QString s ="data.txt";

    qDebug(s.toLatin1());
    QFile qf(s);
    qf.open(QIODevice::ReadOnly | QIODevice::Text);

    QTextStream in(&qf);
    while (!in.atEnd())
    {
        QString level = in.readLine();
        QString cname = in.readLine();
        qint64 cid = in.readLine().toLongLong();
        if (level == "1") {
            _scoreModel1->fillScores(myScore(cname,cid));
            lastScore1 = cid;
        } else if (level == "2") {
            _scoreModel2->fillScores(myScore(cname,cid));
            lastScore2 = cid;
        } else {
            _scoreModel3->fillScores(myScore(cname,cid));
            lastScore3 = cid;
        }
    }
    qf.close();
}

void Mediator::insertScore(QString scoreName, qint64 scoreId, qint8 what)
{
    bool change = false;
    if (what == 0) {
        if((scoreId >= lastScore1) || (_scoreModel1->rowCount()<24)) {
            qint8 i = 0;
            bool lep = true;
            qint8 place = 0;
            while ((i < _scoreModel1->rowCount()) && (lep == true)) {
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel1->getScore(i, scoreName0, scoreId0);
                place = i;
                cout << "A" << scoreId0 << endl;
                cout << "B" << scoreId << endl;
                if (scoreId0 > scoreId) {
                    place = i;
                    cout << "C" << place << endl;
                    lep = false;
                }
                i++;
            }

            _scoreModel1->addScore(myScore(scoreName,scoreId), place);
            lastScore1 = scoreId;
            if(_scoreModel1->rowCount()>=24) {
                deleteScore(_scoreModel1->rowCount()-2, 0);
            }
            change = true;
        }
    } else if (what == 1) {
        if((scoreId >= lastScore2) || (_scoreModel2->rowCount()<24)) {
            qint8 i = 0;
            bool lep = true;
            qint8 place = 0;
            while ((i < _scoreModel2->rowCount()) && (lep == true)) {
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel2->getScore(i, scoreName0, scoreId0);
                place = i+1;
                if (scoreId0 > scoreId) {
                    place = i;
                    lep = false;
                }
                i++;
            }
            _scoreModel2->addScore(myScore(scoreName,scoreId), place);
            QString scoreName0;
            qint64 scoreId0;
            _scoreModel2->getScore(_scoreModel2->rowCount()-1, scoreName0, scoreId0);


            lastScore2 = scoreId0;
            if(_scoreModel2->rowCount()>=24) {
                deleteScore(_scoreModel2->rowCount()-2, 0);
            }
            change = true;
        }
    } else if (what == 2) {
        if((scoreId >= lastScore3) || (_scoreModel3->rowCount()<24)) {
            qint8 i = 0;
            bool lep = true;
            qint8 place = 0;
            while ((i < _scoreModel3->rowCount()) && (lep == true)) {
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel3->getScore(i, scoreName0, scoreId0);
                place = i;
                cout << "A" << scoreId0 << endl;
                cout << "B" << scoreId << endl;
                if (scoreId0 > scoreId) {
                    place = i;
                    cout << "C" << place << endl;
                    lep = false;
                }
                i++;
            }

            _scoreModel3->addScore(myScore(scoreName,scoreId), place);
            lastScore3 = scoreId;
            if(_scoreModel3->rowCount()>=24) {
                deleteScore(_scoreModel3->rowCount()-2, 0);
            }
            change = true;
        }
    }

    if (change == true) {
        QString s ="data.txt";
        QFile qf(s);
        QTextStream out(&qf);

        qf.open(QIODevice::WriteOnly | QIODevice::Text);
        for (int i=0;i<_scoreModel1->rowCount();i++)
        {
            QString n;
            qint64 c;
            _scoreModel1->getScore(i,n,c);
            out<<1<<endl;
            out<<n<<endl;
            out<<c<<endl;
        }
        for (int i=0;i<_scoreModel2->rowCount();i++)
        {
            QString n;
            qint64 c;
            _scoreModel2->getScore(i,n,c);
            out<<2<<endl;
            out<<n<<endl;
            out<<c<<endl;
        }
        for (int i=0;i<_scoreModel3->rowCount();i++)
        {
            QString n;
            qint64 c;
            _scoreModel3->getScore(i,n,c);
            out<<3<<endl;
            out<<n<<endl;
            out<<c<<endl;
        }
        qf.close();
    }
}


void Mediator::deleteScore(int row, qint8 what)
{
    if (what == 0) {
        _scoreModel1->deleteScore(row);
    } else if (what == 1) {
        _scoreModel2->deleteScore(row);
    } else if (what == 2) {
        _scoreModel3->deleteScore(row);
    }

    QString s ="data.txt";
    QFile qf(s);
    QTextStream out(&qf);

    qf.open(QIODevice::WriteOnly | QIODevice::Text);
    for (int i=0;i<_scoreModel1->rowCount();i++)
    {
        QString n;
        qint64 c;
        _scoreModel1->getScore(i,n,c);
        out<<1<<endl;
        out<<n<<endl;
        out<<c<<endl;
    }
    for (int i=0;i<_scoreModel2->rowCount();i++)
    {
        QString n;
        qint64 c;
        _scoreModel2->getScore(i,n,c);
        out<<2<<endl;
        out<<n<<endl;
        out<<c<<endl;
    }
    for (int i=0;i<_scoreModel3->rowCount();i++)
    {
        QString n;
        qint64 c;
        _scoreModel3->getScore(i,n,c);
        out<<3<<endl;
        out<<n<<endl;
        out<<c<<endl;
    }
    qf.close();
}
