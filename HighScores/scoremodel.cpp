#include "scoremodel.h"

scoreModel::scoreModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

/**
 * @brief scoreModel::addScore Stores the nickname and time that the user did in game to the list
 * @param score The nickname and time that the user did in the last game
 * @param place The place of the list where the score needs to be added
 */
void scoreModel::addScore(const myScore &score, qint8 place)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scores.insert(place, score); // Adds the score in the right place
    endInsertRows();
}

/**
 * @brief scoreModel::fillScores Inserts all scores, one after another
 * @param score The nickname and time that the user did (on previous games)
 */
void scoreModel::fillScores(const myScore &score)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scores << score;
    endInsertRows();
}

/**
 * @brief scoreModel::deleteScore Deletes the score that the user choosed from the list
 * (although it works, the option has been removed from GUI, because the was not needed)
 * @param row The row that the score exists in the list
 */
void scoreModel::deleteScore(int row)
{
    beginRemoveRows(QModelIndex(),row,row);
    m_scores.removeAt(row);
    endRemoveRows();
}

/**
 * @brief scoreModel::getScore Returns the nickname and the time of the choosen row
 * @param row The row of the list that we want to get the nickname and time
 * @param mname The nickname stored in that row
 * @param cscore The time scored in that row
 */
void scoreModel::getScore(int row, QString &mname, qint64 &cscore)
{
    mname = m_scores[row].name();
    cscore = m_scores[row].score();
}

/**
 * @brief scoreModel::rowCount Returns the size of the list
 * @param parent The poinder of the list
 * @return The size of the list
 */
int scoreModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_scores.count();
}

/**
 * @brief scoreModel::data Gets the data of the selected index and returns it according to the type we ask
 * @param index The role we want to return
 * @param role The type of role (nickname or time)
 * @return The name or time
 */
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

/**
 * @brief scoreModel::roleNames The rules that are being used in qml to get the name and time of the score
 * @return These rules
 */
QHash<int, QByteArray> scoreModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ScoreRole] = "scoreId";
    return roles;
}
