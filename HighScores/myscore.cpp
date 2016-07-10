#include "myscore.h"

myScore::myScore(const QString &name, const qint64 &score)
    : m_name(name), m_score(score)
{
}

QString myScore::name() const
{
    return m_name;
}

void myScore::setName(const QString &name)
{
    if (name != m_name) {
        m_name = name;
    }
}

qint64 myScore::score() const
{
    return m_score;
}

void myScore::setScore(const qint64 &score)
{
    if (score != m_score) {
        m_score = score;
    }
}
