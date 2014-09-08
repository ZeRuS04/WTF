#ifndef SELECTPLAYER_H
#define SELECTPLAYER_H

#include <QWidget>
#include <QVBoxLayout>
#include <QLineEdit>
#include <QListWidget>

class SelectPlayer : public QWidget
{
    Q_OBJECT
public:
    explicit SelectPlayer(QWidget *parent = 0);
private:
    QVBoxLayout layout_;
    QLineEdit line_;
    QListWidget playerList_;
signals:

public slots:

};

#endif // SELECTPLAYER_H
