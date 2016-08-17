#ifndef MEDIATOR_H
#define MEDIATOR_H

#include <QObject>
#include"scoremodel.h"
#include<iostream>
class Mediator : public QObject
{
    scoreModel *_scoreModel1;
    scoreModel *_scoreModel2;
    scoreModel *_scoreModel3;
    qint64 lastScore1;
    qint64 lastScore2;
    qint64 lastScore3;

    Q_OBJECT
    Q_PROPERTY(scoreModel* myModel1 READ myModel1 WRITE setScoreModel1 NOTIFY scoreModelChanged)
    Q_PROPERTY(scoreModel* myModel2 READ myModel2 WRITE setScoreModel2 NOTIFY scoreModelChanged)
    Q_PROPERTY(scoreModel* myModel3 READ myModel3 WRITE setScoreModel3 NOTIFY scoreModelChanged)


public:
    explicit Mediator(QObject *parent = 0);
    void sortingScores();
    void setScoreModel1(scoreModel* m)
    {
        _scoreModel1 = m;
        emit scoreModelChanged();
    }
    scoreModel* myModel1()
    {
        return _scoreModel1;
    }

    void setScoreModel2(scoreModel* m)
    {
        _scoreModel2 = m;
        emit scoreModelChanged();
    }
    scoreModel* myModel2()
    {
        return _scoreModel2;
    }

    void setScoreModel3(scoreModel* m)
    {
        _scoreModel3 = m;
        emit scoreModelChanged();
    }
    scoreModel* myModel3()
    {
        return _scoreModel3;
    }
    // */
signals:
    void scoreModelChanged();
public slots:
    void insertScore(QString scoreName, qint64 scoreId, qint8 what);
    void clearScores();
    void deleteScore(int row, qint8 what);
};

#endif // MEDIATOR_H
