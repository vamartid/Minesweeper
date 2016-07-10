#include "mediator.h"
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>

Mediator::Mediator(QObject *parent) : QObject(parent)
{
    _scoreModel1 = new scoreModel();
    _scoreModel2 = new scoreModel();
    _scoreModel3 = new scoreModel();
  //  insertScore("Μπλε","blue");

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
            _scoreModel1->addScore(myScore(cname,cid));
        } else if (level == "2") {
            _scoreModel2->addScore(myScore(cname,cid));
        } else {
            _scoreModel3->addScore(myScore(cname,cid));
        }
    }
    qf.close();

}
void Mediator::insertScore(QString scoreName, qint64 scoreId, qint8 what)
{
    if (what == 0) {
        _scoreModel1->addScore(myScore(scoreName,scoreId));
    } else if (what == 1) {
        _scoreModel2->addScore(myScore(scoreName,scoreId));
    } else if (what == 2) {
        _scoreModel3->addScore(myScore(scoreName,scoreId));
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
