import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import MeuiKit 1.0 as Meui

Item {
    id: buttonsView

    property var labels
    property var targets
    property int rowsCount: 5

    signal buttonClicked(string strToAppend)
    signal buttonLongPressed(string strToAppend)

    Grid {
        id: grid
        anchors.centerIn: parent
        anchors.margins: Meui.Units.smallSpacing
        columns: getColumnsCount()
        rows: buttonsView.rowsCount

        Repeater {
            model: buttonsView.labels

            MouseArea {
                id: buttonRect
                width: buttonsView.width / grid.columns - Meui.Units.smallSpacing / 2
                height: buttonsView.height / grid.rows - Meui.Units.smallSpacing / 2
                onClicked: buttonsView.buttonClicked(targets[index])
                onPressAndHold: buttonsView.buttonLongPressed(targets[index])
                hoverEnabled: true

                Rectangle {
                    anchors.centerIn: parent
                    radius: Meui.Theme.smallRadius
                    width: parent.width - radius
                    height: parent.height - radius
                    color: buttonRect.pressed ? 
                        Meui.Theme.highlightColor
                        : buttonRect.containsMouse ?
                            Meui.Theme.darkMode ?
                                Qt.lighter(Meui.Theme.backgroundColor, 1.25)
                                : Qt.darker(Meui.Theme.backgroundColor, 1.1)
                            : Meui.Theme.backgroundColor

                    border.width: 1
                    border.color: Meui.Theme.darkMode ? Qt.lighter(Meui.Theme.backgroundColor, 1.1) : Qt.darker(Meui.Theme.backgroundColor, 1.1)

                    Behavior on color {
                        ColorAnimation {
                            /*
                                50 is way too fast for a 60hz monitor to display,
                                and for an eye to catch it happening.
                            */
                            duration: 100
                            easing.type: Easing.InOutCubic
                        }
                    }
                }

                Text {
                    anchors.fill: parent
                    text: modelData
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPointSize: Math.round(buttonRect.height / 5)
                    font.pointSize: Math.round(buttonRect.height / 5)
                    color: buttonRect.pressed ? Meui.Theme.highlightedTextColor : Meui.Theme.textColor
                }
            }
        }
    }

    function getColumnsCount() {
        return Math.ceil(buttonsView.labels.length / buttonsView.rowsCount);
    }
}
