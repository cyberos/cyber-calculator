import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Rectangle {
    id: buttonsPanel

    property alias computedHeight: num_view.height

    height: computedHeight

    Row {
        anchors.fill: parent

        ButtonsView {
            id: num_view
            color: "white"
            labels: ['AC', '%', '<-', '/', '7', '8', '9', '*', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '()', '=']
            targets: ['AC', '%', '<-', '/', '7', '8', '9', '*', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '()', '=']
            onButtonClicked: zone.appendToTextField(strToAppend)
        }
    }
}
