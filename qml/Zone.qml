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
                    rightPadding: 10
                    topPadding: 10
                    text: historyModel.get(index).text
                    height: 50
                    width: rootWindow.width

                    MouseArea {
                        hoverEnabled: true
                    }
                }
            }
        }
    }

    TextField {
        id: textField
        selectByMouse: true
        width: rootWindow.width
        height: 50
        horizontalAlignment: TextInput.AlignRight
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        focus: Qt.StrongFocus

        background: Rectangle {
            border.width: 0
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            acceptedButtons: Qt.NoButton
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
            textField.insert(textField.length, text)
        }
    }
}
