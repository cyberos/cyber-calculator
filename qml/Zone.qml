import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: zone

    ScrollView {
        id: scrollView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: textField.top

        ListView {
            id: listView
            width: rootWindow.width
            model: ListModel { id: historyModel }
            clip: true

            onCountChanged: {
                // Automatically scroll list to end / bottom
                listView.currentIndex = count - 1
            }

            delegate: Row {
                Label {
                    horizontalAlignment: Qt.AlignRight
                    leftPadding: 10
                    rightPadding: 10
                    topPadding: 10
                    text: historyModel.get(index).text
                    elide: Text.ElideMiddle
                    width: rootWindow.width
                    height: 50

                    MouseArea {
                        hoverEnabled: true
                    }
                }
            }
        }
    }

    CTextField {
        id: textField

        Keys.onReturnPressed: {
            appendToTextField('=')
        }
        Keys.onEnterPressed: {
            appendToTextField('=')
        }
    }

    function appendToTextField(text) {
        if (text === '=') {
            var res = calculate(textField.text)
            if (res !== '') {
                var expressionText = textField.text
                textField.text = res;
                expressionText = expressionText + " = " + res
                historyModel.append({"text": expressionText})
            }
        } else if (text === 'AC') {
            textField.clear()
        } else {
            textField.insert(textField.cursorPosition, text)
        }
    }
}
