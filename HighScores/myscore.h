#ifndef MYCOLOR_H
#define MYCOLOR_H
#include <QString>

class myScore
{
public:
    myScore(const QString &name, const qint64 &score);

    QString name() const;
    void setName(const QString &name);

    qint64 score() const;
    void setScore(const qint64 &score);
private:
    QString m_name;
    qint64 m_score;
};

#endif // MYCOLOR_H
