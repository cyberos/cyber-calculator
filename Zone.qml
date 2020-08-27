import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Rectangle {
    id: zone

    ScrollView {
        id: scrollView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: textField.top

        ListView {
            width: rootWindow.width
            model: 20
            clip: true

            delegate: Row {
                Label {
                    horizontalAlignment: Qt.AlignRight
                    rightPadding: 10
                    topPadding: 10
                    text: "Item " + (index + 1)
                    height: 50
                    width: rootWindow.width

                }
            }
        }
    }

    TextField {
        id: textField
        selectByMouse: true
        width: rootWindow.width
        height: 40
        horizontalAlignment: TextInput.AlignRight
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        focus: Qt.StrongFocus

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            acceptedButtons: Qt.NoButton
        }
    }

    function appendToTextField(text) {
        if (text === '=') {
            return;
        }


        textField.insert(textField.length, text)
    }

    function scrollToBottom() {

    }
}
