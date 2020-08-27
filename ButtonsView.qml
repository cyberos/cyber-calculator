import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import "."

Rectangle {
    id: buttonsView
    implicitHeight: grid.implicitHeight
    implicitWidth: grid.implicitWidth

    property var labels
    property var targets
    property int rowsCount: 5
    property int fontSize: 17

    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        columns: getColumnsCount()
        rows: buttonsView.rowsCount
        rowSpacing: 10
        columnSpacing: 0
        topPadding: 10
        bottomPadding: 10

        Repeater {
            model: buttonsView.labels

            Label {
                text: modelData
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                width: rootWindow.width / 4
                height: 50
                font.pixelSize: buttonsView.fontSize
                color: "black";

                MouseArea {
                    anchors.fill: parent
                    onClicked: buttonsView.buttonClicked(targets[index])
                    onPressAndHold: buttonsView.buttonLongPressed(targets[index])
                }
            }
        }
    }

    function getColumnsCount() {
        return Math.ceil(buttonsView.labels.length / buttonsView.rowsCount);
    }
}
