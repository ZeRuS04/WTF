#include "selectplayer.h"

SelectPlayer::SelectPlayer(QWidget *parent) :
    QWidget(parent)
{
    layout_.addWidget(&playerList_);
    layout_.addWidget(&line_);
    setLayout(&layout_);
}
