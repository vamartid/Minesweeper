#include "scoremodel.h"

scoreModel::scoreModel(QObject *parent)
    : QAbstractListModel(parent)
{
}
void scoreModel::addScore(const myScore &score)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scores << score;
    endInsertRows();
}
void scoreModel::deleteScore(int row)
{
    beginRemoveRows(QModelIndex(),row,row);
    m_scores.removeAt(row);
    endRemoveRows();
}
void scoreModel::getScore(int row, QString &mname, qint64 &cscore)
{
    mname = m_scores[row].name();
    cscore = m_scores[row].score();
}
int scoreModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_scores.count();
}

QVariant scoreModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_scores.count())
        return QVariant();

    const myScore &score = m_scores[index.row()];
    if (role == NameRole)
        return score.name();
    else if (role == ScoreRole)
        return score.score();
    return QVariant();
}
QHash<int, QByteArray> scoreModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ScoreRole] = "scoreId";
    return roles;
}
