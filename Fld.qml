import QtQuick 2.2

Rectangle {
    id: fld
    radius: 5;
    border.width: 1;
    border.color: "black";
    color: Qt.rgba(1,1,1,0.8);
    property string txt: "";
    property color colorTxt: "black";
    property int fntSize: 25

    Text{
        id: buttonText
        anchors.fill: parent;
        text: parent.txt;
        color: parent.colorTxt;
        horizontalAlignment: Text.AlignHCenter;
        verticalAlignment: Text.AlignVCenter;
        font.pixelSize: parent.fntSize;
        wrapMode: Text.WordWrap;
    }
}
