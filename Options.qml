import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: optionField
    property color bgnColor: "white";
    color: bgnColor;
    Rectangle{
        id: butField
        width: parent.width/4*3;
        height: parent.height/5*4;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter:  parent.verticalCenter;
        color: parent.bgnColor;
        Column{
            spacing: 5;
            Text{
                id: slidTxt
                width: butField.width
                text: qsTr("Number of poll options:")
                color: "white";
                horizontalAlignment: Text.AlignHCenter;
                wrapMode: Text.WordWrap;
                font.pointSize: 14
            }
            Row{
                spacing: 20
                Slider{
                    id: varCount;
                    width: butField.width/5*4;
                    maximumValue: 6.0;
                    minimumValue: 2.0;
                    stepSize: 1.0;
                    value: 4.0;
                    onValueChanged: log.setVariantCount(value);
                }
                Text{
                    id: slideValue;
                    text: varCount.value;
                    color: "white";
                    font.pointSize: 24
                }
            }
            Btn{
                id: back
                width: butField.width;
                height: butField.height/10;
                anchors.horizontalCenter: parent.horizontalCenter;
                txt: qsTr("Back");
                fntSize: height/3;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        gameField.gState = 2;
                        gameField.nextQuest();
                        mMenu.visible = true;
                        mMenu.optnsVisible = false;
                    }
                }
            }
        }

    }
}
