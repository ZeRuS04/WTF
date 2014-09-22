import QtQuick 2.2
import QtQuick.Controls 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("WTF?!")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Menu")
                onTriggered: {
                    mMenu.visible = true;
                    mMenu.gameVisible = false;
                    mMenu.optnsVisible = false;
                    mMenu.statVisible = false;
                    mMenu.chgPlrVisible = false;
                }
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }
    Image {
        id: background;
        anchors.fill: parent;
        fillMode: Image.Tile
        horizontalAlignment: Image.AlignHCenter;
        verticalAlignment: Image.AlignVCenter;
        source: "/bgn.gif"

    }


    Rectangle{
        id: gameField;
        anchors.fill: parent;
        color:bgnColor;
        visible: mMenu.gameVisible;

        property int score: log.score();
        property string playerName: log.playerName();
        property int varintCount: log.variantCount();
        property color bgnColor: Qt.rgba(0,0,0,0);
        property var answButtons;
        property int gState: 0 ;//0-игра, 1-ответы, 2-Options

        Component.onCompleted: btCol.createAnswButton() ;

        function nextQuest(){
            if(!gameField.gState){
                log.skipQuest();

            }
            gameField.score = log.score();
            flag.source = log.randImgURL();
            gameField.varintCount = log.variantCount();
            //??? deleteng btns ???
            btCol.createAnswButton() ;

//                for(var i = 0; i < repBtn.model; i++)
//                {
//                    repBtn.itemAt(i).txt = log.randCountry(i);
//                }


            gameField.gState = 0;
            log.updatePlayerStat();

        }


        Rectangle{
            id:imgField;
            anchors.left: parent.left;
            anchors.top: parent.top;
            color: gameField.bgnColor;
            width:{
                if(parent.width < parent.height)
                    parent.width;
                else
                    parent.width/2;
            }
            height: {
                if(parent.width < parent.height)
                    parent.height/2;
                else
                    parent.height;
            }
            Image {
                id: flag;
                width: parent.width/5*4
                height: parent.height/5*4
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                fillMode: Image.PreserveAspectFit
                source: log.randImgURL();
            }


        }
        Rectangle{
            id: userField;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            color: gameField.bgnColor
            width:{
                if(parent.width < parent.height)
                    parent.width;
                else
                    parent.width/2;
            }
            height: {
                if(parent.width < parent.height)
                    parent.height/2;
                else
                    parent.height;
            }
            Rectangle{
                id: buttons;
                width: parent.width/3*2;
                height: parent.height-score.height;
                anchors.horizontalCenter: parent.horizontalCenter
                color: gameField.bgnColor;
                Column{
                    id: btCol
                    spacing: 2;
                    Rectangle{
                        width: buttons.width;
                        height: buttons.height/(gameField.varintCount+2)/2;
                        color: gameField.bgnColor;
                    }
                    function createAnswButton(){
                        gameField.answButtons = Qt.createComponent("Answers.qml");
                         if (gameField.answButtons.status == Component.Ready)
                             gameField.answButtons.createObject(btCol);
                         gameField.answButtons.destroy();
                    }

                }
            }

        }
        Rectangle{
            id: footer;
            width: parent.width;
            height: parent.height/7;
            anchors.bottom: parent.bottom;
            anchors.left: parent.left;
            color: gameField.bgnColor;

            Rectangle{
                id: score;
                width: parent.width/2;
                height: parent.height;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                color: gameField.bgnColor;
                Text{
                    id: scoreTxt;
                    anchors.fill: parent;
                    horizontalAlignment: Text.AlignHCenter;
                    verticalAlignment:  Text.AlignVCenter;
                    text:"Score: " + gameField.score;
//                    font.pointSize: 9 ;
                    color: "white";

                }
            }
            Rectangle{
                id: nextField
                width: parent.width/2;
                height: parent.height;
                anchors.bottom: parent.bottom;
                anchors.right: parent.right;
                color: gameField.bgnColor;
                Btn{
                    id: next
                    width: parent.width/5*4;
                    height: parent.height/5*4;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    fntSize: height/2;
                    txt: qsTr("Next");
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: gameField.nextQuest();

                    }
                }
            }
        }
        Keys.onPressed: {
            if (event.key == Qt.Key_Back) {
                mMenu.visible = true;
                mMenu.gameVisible = false;
                mMenu.optnsVisible = false;
                mMenu.statVisible = false;
                mMenu.chgPlrVisible = false;
                event.accepted = true;
            }
        }
    }
    Mmenu{
        id: mMenu
        anchors.fill: parent;
        bgnColor: gameField.bgnColor;
        visible: true;
//        Text{
//            anchors.bottom: parent.bottom;
//            anchors.left: parent.left
//            width: parent.width;
//            text: gameField.playerName;
////            font.pointSize: 9 ;
//            color: "white";

//        }
    }
    Options{
        id: optns
        anchors.fill: parent;
        bgnColor: gameField.bgnColor;
        visible: mMenu.optnsVisible;
//        Text{
//            anchors.bottom: parent.bottom;
//            anchors.left: parent.left
//            width: parent.width;
//            text: gameField.playerName;
////            font.pointSize: 9 ;
//            color: "white";

//        }
        Keys.onPressed: {
            if (event.key == Qt.Key_Back) {
                mMenu.visible = true;
                mMenu.gameVisible = false;
                mMenu.optnsVisible = false;
                mMenu.statVisible = false;
                mMenu.chgPlrVisible = false;
                event.accepted = true;
            }
        }
    }
//    PlayerNames{
//        id: chgPlayer
//        anchors.fill: parent;
//        bgnColor: gameField.bgnColor;
//        visible: mMenu.chgPlrVisible;
//        Keys.onPressed: {
//            if (event.key == Qt.Key_Back) {
//                mMenu.visible = true;
//                mMenu.gameVisible = false;
//                mMenu.optnsVisible = false;
//                mMenu.statVisible = false;
//                mMenu.chgPlrVisible = false;
//                event.accepted = true;
//            }
//        }
//    }

    Stats{
        id: stats
        anchors.fill: parent;
        bgnColor: gameField.bgnColor;
        visible: mMenu.statVisible;
//        Text{
//            anchors.bottom: parent.bottom;
//            anchors.left: parent.left
//            width: parent.width;
//            text: gameField.playerName;
////            font.pointSize: 9 ;
//            color: "white";

//        }
        Keys.onPressed: {
            if (event.key == Qt.Key_Back) {
                mMenu.visible = true;
                mMenu.gameVisible = false;
                mMenu.optnsVisible = false;
                mMenu.statVisible = false;
                mMenu.chgPlrVisible = false;
                event.accepted = true;
            }
        }

    }
}
