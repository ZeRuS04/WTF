#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <QDebug>
#include <QObject>
#include <QDir>
#include <QColor>
#include <QStringList>
#include <QChar>
#include <QFile>
#include <QTime>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QMap>
#include <QVariant>
#include <QVector>
#include <QSqlError>
#include "selectplayer.h"

class GameLogic : public QObject
{
    Q_OBJECT
public:
    explicit GameLogic(QObject *parent = 0);
    Q_INVOKABLE QString randImgURL();
    Q_INVOKABLE QString randCountry( int n);
    Q_INVOKABLE bool itIsTrue(const QString &answer);
    Q_INVOKABLE QString whatsTheFlag()
    {
        return curCountry_;
    }
    Q_INVOKABLE int score(){ return score_.at(variantCount_-2); }
    Q_INVOKABLE int series(){ return series_.at(variantCount_-2); }
    Q_INVOKABLE QString playerName(){ return playerName_; }
    Q_INVOKABLE void skipQuest(){
        curSerie_ = 0;
        score_[variantCount_-2]--;
    }
    Q_INVOKABLE QColor varButColor() const
    {
        return varButColor_;
    }
    Q_INVOKABLE QColor varButColorPr() const
    {
        return varButColorPr_;
    }
    Q_INVOKABLE QColor varButTextColor() const
    {
        return varButTextColor_;
    }
    Q_INVOKABLE void setButColor(const QColor &varButColor,const QColor &varButColorPr,
                        const QColor &varButTextColor)
    {
        varButColor_ = varButColor;
        varButColorPr_ = varButColorPr;
        varButTextColor_ = varButTextColor;
    }

    Q_INVOKABLE int variantCount() const
    {
        return variantCount_;
    }
    Q_INVOKABLE void setVariantCount(int variantCount)
    {
        variantCount_ = variantCount;
    }

    Q_INVOKABLE int getPlayersCount();
    Q_INVOKABLE void getPlayersNames();
    Q_INVOKABLE QString getPlayersName(int i)
    {
        return playerNames_.at(i);
    }
    Q_INVOKABLE int getPlayersScore(int i, int varCount);
    Q_INVOKABLE int getPlayersSeries(int i, int varCount);
    Q_INVOKABLE void addNewPlayer(const QString & name);
    Q_INVOKABLE void deletePlayer(const QString & name);
    Q_INVOKABLE void changePlayer(const QString & name);
    Q_INVOKABLE void updatePlayerStat();

private:
    QDir fileDir_;
    QMap<QString, QString> fileName_;

    QStringList countryEng_;
//    QStringList countryRus_;
    QSqlDatabase db_;
    QVector<QString> playerNames_;


    int variantCount_;
    QStringList curVariants_;
    QColor varButColor_;
    QColor varButColorPr_;
    QColor varButTextColor_;

    QStringList notUsedNames_;
    QStringList usedNames_;

    QString playerName_;
    QVector<int> score_;
    QVector<int> series_;
    int curSerie_;

    QString curCountry_;
    int curCountryPos_;

    SelectPlayer select_;

    bool parsTxtFiles();
    void parsePngFilse();
    bool dbCreateConnection();
//    bool dbLoadProfile();


signals:

public slots:


};

#endif // GAMELOGIC_H
