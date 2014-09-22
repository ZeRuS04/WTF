import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: plNamesField
    property color bgnColor: "white";
    color: bgnColor;
    Rectangle{
        id: butField
        width: parent.width/4*3;
        height: parent.height/5*4 - newPlayer.height;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter:  parent.verticalCenter;
        color: parent.bgnColor;
        function updateRep(){
            rep.model = 0;
            rep.model = log.getPlayersCount();
        }

        Flickable{
            anchors.fill: parent;
            contentHeight: column.height;

            Column{
                id: column;
                spacing: 5;
                Text{
                    id: slidTxt
                    width: butField.width
                    text: qsTr("Select player name:")
                    color: "white";
                    horizontalAlignment: Text.AlignHCenter;
                    wrapMode: Text.WordWrap;
                    font.pointSize: 14
                }
                Repeater{
                    id: rep;
                    model: log.getPlayersCount();
                    Row{
                        Btn{
                            id: plrBtn;
                            width: butField.width-delBtn.width;
                            height: plNamesField.height/10;
                            txt: log.getPlayersName(index);
                            MouseArea{
                                anchors.fill: parent;
                                onClicked: {
                                    log.changePlayer(plrBtn.txt);
                                    gameField.gState = 2;
                                    gameField.nextQuest();
                                    mMenu.visible = true;
                                    mMenu.chgPlrVisible = false;
                                }
                            }
                        }
                        Btn{
                            id: delBtn;
                            width: height;
                            height: plNamesField.height/10;
                            txt: "X";
                            colorTxt: "red";
                            fntSize: height/2;
                            MouseArea{
                                anchors.fill: parent;
                                onClicked: {
                                    log.deletePlayer(log.getPlayersName(index));
                                    delBtn.visible = false;
                                    plrBtn.visible = false;
                                }
                            }
                        }
                    }

                }
            }
        }
        Rectangle{
            id: newPlayer
            anchors.top: parent.bottom;
            anchors.left: parent.left;
            anchors.right: parent.right;
            height: plNamesField.height/10;
            color: plNamesField.bgnColor;
            function createNameFinish(){
                if(input.text !== ""){
                    Qt.inputMethod.hide();
                    log.addNewPlayer(input.text);
                    input.text = "";
                    mMenu.visible = true;
                    mMenu.chgPlrVisible = false;
                    gameField.gState = 2;
                    gameField.nextQuest();
                }
            }

            Btn{
                anchors.left: parent.left;
                anchors.right: okBtn.left;
                anchors.top: parent.top;
                anchors.bottom: parent.bottom;
                TextInput{
                    id: input;
                    anchors.fill: parent;
                    font.pixelSize: height/2;
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: TextInput.AlignVCenter
                    text: "";
                    validator: RegExpValidator { regExp: /[0-9A-Za-zА-Яа-я]+/; }
                    maximumLength: 12;
                    onEditingFinished: Qt.inputMethod.hide();
                }
            }
            Btn{
                id: okBtn;
                width: height;
                height: input.height;
                anchors.right: parent.right;
                txt: "OK";
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: newPlayer.createNameFinish()
                }
            }

        }
    }
    onVisibleChanged: {
        gameField.playerName = log.playerName();
        rep.model = 0;
        rep.model = log.getPlayersCount();
    }
}
