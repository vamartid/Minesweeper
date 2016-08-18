#include "mediator.h"
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>

Mediator::Mediator(QObject *parent) : QObject(parent)
{
    _scoreModel1 = new scoreModel();
    _scoreModel2 = new scoreModel();
    _scoreModel3 = new scoreModel();
    lastScore1 = -1;
    lastScore2 = -1;
    lastScore3 = -1;
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

/**
 * @brief Mediator::insertScore Adds a value in the models (if it is small enough or values are less than 3) and updates the files
 * @param scoreName The nickname that user had given
 * @param scoreId The time that the user did on the game
 * @param whitchModel The model that the value belongs
 */
void Mediator::insertScore(QString scoreName, qint64 scoreId, qint8 whitchModel) {

    // LEAVE THIS CLASS, ILL FIX IT

    bool change = false; // If a model changed (used to check if update is needed on the file)
    bool newScoreSmaller = false; // The new score is smaller than another
    qint8 i = 0; // Temp to keep the place on the model
    qint8 place = 0; // The place that the score needs to be added
    if (whitchModel == 0) {
        // We keep 3 scores in each model
        if ((scoreId < lastScore1) || (_scoreModel1->rowCount()<3)) {
            while ((i < _scoreModel1->rowCount()) && (!newScoreSmaller)) { // Check from what score is smaller
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel1->getScore(i, scoreName0, scoreId0);
                place = i+1; // If score is not smaller then it has last place on model
                if (scoreId0 > scoreId) { // Score is smaller
                    place = i; // Place of score that needs to be added in model
                    newScoreSmaller = true;
                }
                i++;
            }
            _scoreModel1->addScore(myScore(scoreName,scoreId), place); // Add score to model
            if(_scoreModel1->rowCount()>3) { // If model is more than 3..
                deleteScore(_scoreModel1->rowCount()-1, 0); // .. then remove last
            }
            QString scoreName0;
            qint64 scoreId0;
            _scoreModel1->getScore(_scoreModel1->rowCount()-1, scoreName0, scoreId0); // Get and store last score
            lastScore1 = scoreId0;
            change = true; // Change has been done, so update file
        }
    } else if (whitchModel == 1) {
        if((scoreId < lastScore2) || (_scoreModel2->rowCount()<3)) {
            while ((i < _scoreModel2->rowCount()) && (!newScoreSmaller)) {
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel2->getScore(i, scoreName0, scoreId0);
                place = i+1;
                if (scoreId0 > scoreId) {
                    place = i;
                    newScoreSmaller = true;
                }
                i++;
            }
            _scoreModel2->addScore(myScore(scoreName,scoreId), place);
            if(_scoreModel2->rowCount()>=3) {
                deleteScore(_scoreModel2->rowCount()-1, 0);
            }
            QString scoreName0;
            qint64 scoreId0;
            _scoreModel2->getScore(_scoreModel2->rowCount()-1, scoreName0, scoreId0);
            lastScore2 = scoreId0;
            change = true;
        }
    } else if (whitchModel == 2) {
        if((scoreId < lastScore3) || (_scoreModel3->rowCount()<3)) {
            while ((i < _scoreModel3->rowCount()) && (!newScoreSmaller)) {
                QString scoreName0;
                qint64 scoreId0;
                _scoreModel3->getScore(i, scoreName0, scoreId0);
                place = i+1;
                if (scoreId0 > scoreId) {
                    place = i;
                    newScoreSmaller = true;
                }
                i++;
            }

            _scoreModel3->addScore(myScore(scoreName,scoreId), place);
            if(_scoreModel3->rowCount()>=3) {
                deleteScore(_scoreModel3->rowCount()-1, 0);
            }
            QString scoreName0;
            qint64 scoreId0;
            _scoreModel3->getScore(_scoreModel3->rowCount()-1, scoreName0, scoreId0);
            lastScore3 = scoreId0;
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

/**
 * @brief Mediator::clearScores Deletes all the values and reinitializes the models
 */
void Mediator::clearScores() {
    QString s ="data.txt";
    QFile qf(s);
    QTextStream out(&qf);
    qf.open(QIODevice::WriteOnly | QIODevice::Text);
    out<<""; // write nothing so as to clear it
    qf.close();
    _scoreModel1 = new scoreModel(); // reinitialise the models
    _scoreModel2 = new scoreModel();
    _scoreModel3 = new scoreModel();
    lastScore1 = -1; // Even if the values of the lastScores dont change there is no difference in program
    lastScore2 = -1;
    lastScore3 = -1;
}

/**
 * @brief Mediator::deleteScore Deletes the score that user has choosen from the GUI (it is not called from anywhere at this moment, but it works)
 * @param row The row of the score that needs to be deleted in the GUI and the model
 * @param whitchModel The model that we want to change
 */
void Mediator::deleteScore(int row, qint8 whitchModel) {
    if (whitchModel == 0) {
        _scoreModel1->deleteScore(row); // delete the score
    } else if (whitchModel == 1) {
        _scoreModel2->deleteScore(row);
    } else if (whitchModel == 2) {
        _scoreModel3->deleteScore(row);
    }

    // Update the file
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
