import QtQuick 2.9
import QtQuick.Controls 2.5
import org.cyber.calculator 1.0

ApplicationWindow {
    visible: true
    width: 350
    height: 550
    minimumWidth: 350
    minimumHeight: 550
    title: qsTr("Calculator")
    id: rootWindow

    CalcEngine {
        id: calcEngine

        Component.onCompleted: {
            console.log("load calc engine finished")
        }
    }

    Zone {
        id: zone
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: buttonsPanel.top
    }

    ButtonsPanel {
        id: buttonsPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: visible
    }

    function calculate(evalText) {
        var res = calcEngine.eval(evalText)
        return res
    }

}
