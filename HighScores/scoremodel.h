#ifndef COLORMODEL_H
#define COLORMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <stdlib.h>

#include <iostream>
#include <list>
#include <string>
#include <cctype>

#include "myscore.h"

class scoreModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        enum ScoreRoles {
            NameRole = Qt::UserRole + 1,
            ScoreRole
        };

        scoreModel(QObject *parent = 0);

        void addScore(const myScore &score, qint8 place);
        void fillScores(const myScore &score);
        void getScore(int row, QString &name, qint64 &score);

        int rowCount(const QModelIndex & parent = QModelIndex()) const;

        QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

        void deleteScore(int row);
    protected:
        QHash<int, QByteArray> roleNames() const;
    private:
        QList<myScore> m_scores;
};

#endif // COLORMODEL_H
