import QtQuick 2.0

Repeater{
    id: repBtn
    model: gameField.varintCount;
    Btn{
        id: oneButton;
        width: buttons.width;
        height: buttons.height/(gameField.varintCount+1);
        state: "Normal";
        txt: log.randCountry(index);

        states: [
            State{
                name: "Normal"
                PropertyChanges {
                    target: oneButton;
                    color: log.varButColor();
                    colorTxt: log.varButTextColor();
                }
            },
            State{
                    name: "Pressed"
                    PropertyChanges {
                        target: oneButton;
                        color: log.varButColorPr();
                        colorTxt:log.varButTextColor();
                    }
            },
            State{
                    name: "Correct"
                    PropertyChanges {
                        target: oneButton;
                        color: Qt.rgba(0,1,0,0.7);
                        colorTxt: log.varButTextColor();
                    }
                    when: ((oneButton.txt === log.whatsTheFlag()) && gameField.gState)
            },
            State{
                    name: "Fail"
                    PropertyChanges {
                        target: oneButton;
                        color: Qt.rgba(1,0,0,0.7);
                        colorTxt: log.varButTextColor();
                    }
                    when: ((oneButton.txt !== log.whatsTheFlag()) && gameField.gState)
            }

        ]

        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;

            onEntered: {
                if(!gameField.gState){
                    oneButton.state = "Pressed"
                }
            }
            onExited: {
                if(!gameField.gState){
                    oneButton.state = "Normal"
                }
            }
            onPressed: {
                if(!gameField.gState){
                    oneButton.state = "Pressed"
                }
            }

            onClicked: {
                if(!gameField.gState){
                    gameField.gState = 1;
                    log.itIsTrue(oneButton.txt)
                    gameField.score = log.score();
                }

            }

        }
    }
}
