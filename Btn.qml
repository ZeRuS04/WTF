import QtQuick 2.0

Rectangle {
    id: btn
    state: "Normal";
    radius: 5;
    border.width: 1;
    border.color: "black";
    color: Qt.rgba(1,1,1,0.7);
    property string txt: "";
    property color colorTxt: "white";
    property int fntSize: 30

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

    states: [
        State{
            name: "Normal"
            PropertyChanges {
                target: btn;
                color: log.varButColor();
                colorTxt: log.varButTextColor();
            }
        },
        State{
                name: "Pressed"
                PropertyChanges {
                    target: btn;
                    color: log.varButColorPr();
                    colorTxt:log.varButTextColor();
                }
        }

    ]
    MouseArea{
        anchors.fill: parent;
        hoverEnabled: true;

        onEntered: btn.state = "Pressed"
        onExited: btn.state = "Normal"
        onPressed: btn.state = "Pressed"
    }
}
