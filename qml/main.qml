import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.cyber.calculator 1.0

ApplicationWindow {
    visible: true
    width: 350
    height: 550
    minimumWidth: 350
    minimumHeight: 550
    title: qsTr("Calculator")
    id: rootWindow

    property color backgroundColor: "#F5F5F5"
    property var edgeMargin: 10

    background: Rectangle {
        color: backgroundColor
    }

    CalcEngine {
        id: calcEngine

        Component.onCompleted: {
            console.log("load calc engine finished")
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: edgeMargin

        Zone {
            id: zone
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ButtonsPanel {
            id: buttonsPanel
        }
    }

    function calculate(evalText) {
        var res = calcEngine.eval(evalText)
        return res
    }

}
