import QtQuick 2.2

Rectangle {
    id:menuField
    property color bgnColor: "white";
    property bool gameVisible: false;
    property bool optnsVisible: false;
    property bool statVisible: false;
    property bool chgPlrVisible: true;
    color: bgnColor;
    Rectangle{
        id: butField
        width: parent.width/4*3;
        height: parent.height;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter:  parent.verticalCenter;
        color: parent.bgnColor;
        Column{
            spacing: 2;
            Rectangle{
                id: wTheF
                width: butField.width;
                height: butField.height/4;
                color: menuField.bgnColor;
                Image{
                    id: logo;
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height
                    source: "/logo.png"
                }
            }
            Btn{
                id: start
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Start");
                fntSize: height/3;

                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        menuField.gameVisible = true;
                        menuField.visible = false;
                    }
                }
            }
            Btn{
                id: option
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Option");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        menuField.optnsVisible = true;
                        menuField.visible = false;
                    }
                }
            }
            Btn{
                id: stats
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Statistics");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        menuField.statVisible = true;
                        menuField.visible = false;
                    }

                }
            }
            Btn{
                id: chgName
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Change name");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        menuField.chgPlrVisible = true;
                        menuField.visible = false;
                    }

                }
            }
            Btn{
                id: exit
                width: butField.width;
                height: butField.height/7;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Exit");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: Qt.quit();

                }
            }
        }
    }


}
