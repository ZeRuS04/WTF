#include "gamelogic.h"

GameLogic::GameLogic(QObject *parent) :
    QObject(parent)
{
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));

    setButColor(QColor::fromRgb(255,255,255,178) , "white", "black");

    dbCreateConnection();


    variantCount_ = 4;



    if(!parsTxtFiles())
        return;
    parsePngFilse();



    playerName_ = "No Name";
    for(int i = 0; i < 5; i++)
    {
        score_.push_back(0);
        series_.push_back(0);
    }
    curSerie_ = 0;

    randImgURL();

}


bool GameLogic::parsTxtFiles()
{
    QFile file(":flags_eng.txt");
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
                return false;
    while (!file.atEnd()){
        QString s = file.readLine();
        if((s == ".")||(s == "..")||(s == ""))
            continue;
        s.remove("\n");
        countryEng_.push_back(s);
    }
    notUsedNames_ = countryEng_;
    return true;
}

void GameLogic::parsePngFilse()
{
    fileDir_ = QDir(":/flags");
    QStringList names = fileDir_.entryList();
    int k = 0;
    foreach(QString name, names){
        if((name == ".")||(name == ".."))
            continue;
        fileName_.insert(countryEng_[k] , name);
        k++;
    }
}

bool GameLogic::dbCreateConnection()
{
    db_ = QSqlDatabase::addDatabase("QSQLITE");
    db_.setDatabaseName("wtf_db");
    if (!db_.open()) {
            qDebug() << "database connection error";
            return false;
        }
    QSqlQuery query;

    QString str ="CREATE TABLE playersStat ("
            "id integer PRIMARY KEY NOT NULL,"
            "name VARCHAR(255), "
            "score2 integer, "
            "series2 integer, "
            "score3 integer, "
            "series3 integer, "
            "score4 integer, "
            "series4 integer, "
            "score5 integer, "
            "series5 integer, "
            "score6 integer, "
            "series6 integer, "
            "curvarcount integer"
            ");";

    if (!query.exec(str)) {
        qDebug() << "Databese create 'playersStat' error: " + query.lastError().text();
    }

    return true;
}


QString GameLogic::randImgURL(){

    int num = qrand()%(notUsedNames_.size()-1);
    curCountryPos_ = qrand()%(variantCount_);
    curCountry_ = notUsedNames_.at(num);
    QString imgUrl = "/flags/" + fileName_.value( curCountry_ );
    usedNames_.push_back(curCountry_);
    notUsedNames_.removeAll(curCountry_);
    return imgUrl;
}

QString GameLogic::randCountry( int n )
{
    if(n == curCountryPos_)
        return curCountry_;
    int randC;
    do{
        randC  = qrand()%(notUsedNames_.size()-1);
    }
    while(curVariants_.contains(notUsedNames_.at(randC)) );
    curVariants_.push_back(notUsedNames_.at(randC));
    return notUsedNames_.at(randC);

}

bool GameLogic::itIsTrue(const QString &answer)
{
    //Переброс половины архивных стран в используемые
    if(notUsedNames_.size() < usedNames_.size())
    {
        for(int i = 0; i < usedNames_.size()-1; i+=2)
        {
            QString s = usedNames_.at(i);
            notUsedNames_.push_back(s);
            usedNames_.removeAll(s);
        }
    }

    if(answer == curCountry_){
        score_[variantCount_-2]++;
        curSerie_++;
        return true;
    }
    else{
        score_[variantCount_-2]--;
        curSerie_ = 0;
        return false;
    }
}

int GameLogic::getPlayersCount()
{
    getPlayersNames();
    return playerNames_.size();

}

void GameLogic::getPlayersNames()
{
    playerNames_.clear();
    QSqlQuery query;
    QString str = "SELECT name FROM playersStat;";

    if (!query.exec(str)) {
        qDebug() << "Databese select 'playersStat' error.";
    }
    QSqlRecord rec = query.record();

    while (query.next()) {
        playerNames_.push_back(query.value(rec.indexOf("name")).toString());
    }
    if(playerNames_.empty()){
        playerName_ = "No Name";
        score_.clear();
        series_.clear();
        for(int i = 0; i < 5; i++)
        {
            score_.push_back(0);
            series_.push_back(0);
        }
        curSerie_ = 0;
    }

}

int GameLogic::getPlayersScore(int i, int varCount)
{
    QSqlQuery query;
    QString s = "score%1";
    s = s.arg(varCount);
    QString str = "SELECT %1 FROM playersStat WHERE name = '%2';";
    str = str.arg(s).arg(playerNames_.at(i));

    if (!query.exec(str)) {
        qDebug() << "Databese select 'playersStat' error.";
    }
    QSqlRecord rec = query.record();
    int result = 0;
    while (query.next()) {
        result = query.value(rec.indexOf(s)).toInt();
    }
    return result;
}

int GameLogic::getPlayersSeries(int i, int varCount)
{
    QSqlQuery query;
    QString s = "series%1";
    s = s.arg(varCount);
    QString str = "SELECT %1 FROM playersStat WHERE name = '%2';";
    str = str.arg(s).arg(playerNames_.at(i));

    if (!query.exec(str)) {
        qDebug() << "Databese select 'playersStat' error.";
    }
    QSqlRecord rec = query.record();
    int result = 0;
    while (query.next()) {
        result = query.value(rec.indexOf(s)).toInt();
    }
    return result;
}



void GameLogic::addNewPlayer(const QString &name)
{
    QSqlQuery query;

    QString str = "SELECT id FROM playersStat ORDER BY id DESC ;";

    int id = playerNames_.size();


    str = "INSERT INTO playersStat(id, name, "
            "score2, series2,"
            "score3, series3,"
            "score4, series4,"
            "score5, series5,"
            "score6, series6, curvarcount ) "
            "VALUES (%1, '%2', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4  );";
    str = str.arg(QString("").setNum(id))
               .arg(name);

    if (!query.exec(str)) {
        qDebug() << "Databese insert 'playersStat' error.";
    }

    playerName_ = name;
    score_.clear();
    series_.clear();
    for(int i = 0; i < 5; i++)
    {
        score_.push_back(0);
        series_.push_back(0);
    }
    setVariantCount(4);
    curSerie_ = 0;
    getPlayersNames();
}

void GameLogic::deletePlayer(const QString &name)
{
    QSqlQuery query;
    if(name == playerName()){
        playerName_ = "No Name";
        score_.clear();
        series_.clear();
        for(int i = 0; i < 5; i++)
        {
            score_.push_back(0);
            series_.push_back(0);
        }
        curSerie_ = 0;
    }

    QString str = "DELETE FROM playersStat WHERE name = '%1';";
    str = str.arg(name);

    if (!query.exec(str)) {
        qDebug() << "Databese remove 'playersStat' error.";
    }
    getPlayersNames();
}

void GameLogic::changePlayer(const QString &name)
{
    QSqlQuery query;

    QString str = "SELECT name, "
            " score2, series2,"
            " score3, series3,"
            " score4, series4,"
            " score5, series5,"
            " score6, series6, curvarcount "
            " FROM playersStat WHERE name = '%1' ;";
    str = str.arg(name);

    if (!query.exec(str)) {
        qDebug() << "Databese select 'playersStat' error.";
    }
    QSqlRecord rec = query.record();

    while (query.next()) {
        score_[0] = query.value(rec.indexOf("score2")).toInt();
        series_[0] = query.value(rec.indexOf("series2")).toInt();
        score_[1] = query.value(rec.indexOf("score3")).toInt();
        series_[1] = query.value(rec.indexOf("series3")).toInt();
        score_[2] = query.value(rec.indexOf("score4")).toInt();
        series_[2] = query.value(rec.indexOf("series4")).toInt();
        score_[3] = query.value(rec.indexOf("score5")).toInt();
        series_[3] = query.value(rec.indexOf("series5")).toInt();
        score_[4] = query.value(rec.indexOf("score6")).toInt();
        series_[4] = query.value(rec.indexOf("series6")).toInt();
        setVariantCount(query.value(rec.indexOf("curvarcount")).toInt());
    }
    playerName_ = name;
    curSerie_ = 0;
}

void GameLogic::updatePlayerStat()
{
    QSqlQuery query;
    if(curSerie_ > series_.at(variantCount_-2))
        series_[variantCount_-2] = curSerie_;
    QString str = "UPDATE playersStat "
            " SET score2 = %1, series2 = %2,"
            " score3 = %3, series3 = %4,"
            " score4 = %5, series4 = %6"
            " WHERE name = '%7' ;";
    str = str.arg(score_.at(0)).arg(series_.at(0))
            .arg(score_.at(1)).arg(series_.at(1))
            .arg(score_.at(2)).arg(series_.at(2))
            .arg(playerName_);
    if (!query.exec(str)) {
        qDebug() << "Databese update1 'playersStat' error.";
    }
    str = "UPDATE playersStat "
                " SET score5 = %1, series5 = %2,"
                " score6 = %3, series6 = %4, curvarcount = %5"
                " WHERE name = '%6' ;";
    str = str.arg(score_.at(3)).arg(series_.at(3))
            .arg(score_.at(4)).arg(series_.at(4))
            .arg(variantCount_).arg(playerName_);
    if (!query.exec(str)) {
        qDebug() << "Databese update2 'playersStat' error.";
    }
}
