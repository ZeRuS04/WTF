import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: statField

    property color bgnColor: "white";
    color: bgnColor;

    Flickable{
        width: {
            if(contentWidth > parent.width)
                parent.width;
            else
                contentWidth;
        }
        height: statField.height-butField.height;
        contentHeight: table.height;
        contentWidth: table.width;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: butField.bottom
        Column{
            id: table;
            Row{
                Fld{
                    id: name;
                    width: 200;
                    height: 50;
                    txt: qsTr("Number of poll options:");
                }
                Fld{
                    id: score;
                    width: 150;
                    height: 50;
                    txt: qsTr("Score:");
                }
                Fld{
                    id: series;
                    width: 150;
                    height: 50;
                    txt: qsTr("Max.series:");
                }
            }
            Repeater{
                id: rep;
                model: 5;
                Row{
                    Fld{
                        id: varCount
                        width: 200
                        height: 50
                        txt: index+2
                    }
                    Fld{
                        id: plrScore;
                        width: 150;
                        height: 50;
                        txt: log.getPlayersScore(0, index+2);
                    }
                    Fld{
                        id: plrSeries;
                        width: 150;
                        height: 50;
                        txt: log.getPlayersSeries(0, index+2);
                    }
                }


            }
        }
    }

    Rectangle{
        id: butField
        width: parent.width/4*3;
        height: col.height;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        color: "black";
        Column{
            id: col
            spacing: 5;
            Btn{
                id: back
                width: butField.width;
                height: 50;
                txt: qsTr("Back");
                fntSize: height/2;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        gameField.gState = 2;
                        gameField.nextQuest();
                        mMenu.visible = true;
                        mMenu.statVisible = false;
                    }
                }
            }
//            Row{
//                spacing: 5
//                Text{
//                    id: slidTxt;
//                    width: butField.width-varCount.width;
//                    wrapMode: Text.WordWrap;
//                    text: qsTr("Select number of poll options:");
//                    font.pixelSize: back.fntSize;
//                    color: "white";
//                    horizontalAlignment: Text.AlignRight;

//                }
//                ComboBox{
//                    id: varCount;
//                    property int varC: currentIndex;
//                    currentIndex: log.variantCount()-2;
//                    model: [2, 3, 4, 5, 6];
//                    width: 30;
//                    onCurrentIndexChanged: {
//                        rep.model = 0;
//                        rep.model = log.getPlayersCount();
//                    }
//                }
//            }
        }
    }
    onVisibleChanged: {
        rep.model = 0;
        rep.model = log.getPlayersCount();
    }
}
