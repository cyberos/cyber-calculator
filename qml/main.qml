import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.cyber.calculator 1.0
import MeuiKit 1.0 as Meui

Meui.Window {
    visible: true
    width: 350
    height: 650
    minimumWidth: 350
    minimumHeight: 650
    title: qsTr("Calculator")
    id: rootWindow

    backgroundColor: Meui.Theme.secondBackgroundColor

    headerBar: Rectangle {
        color: "transparent"
        anchors.fill: parent
        anchors.rightMargin: -140

        Label {
            text: rootWindow.title
            // TODO: Make this a separate variable in Meui.Theme,
            //       maybe Meui.Theme.titleBarTextColor?
            color: Meui.Theme.darkMode ? "#cacbce" : "#383838"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
        }
    }

    CalcEngine {
        id: calcEngine

        Component.onCompleted: {
            console.log("load calc engine finished")
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Zone {
            id: zone
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.35
        }

        MemoryButtonsView {
            id: memoryButtons
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            labels: ['MC', 'MR', 'M+', 'M-', 'MS']
            targets: ['MC', 'MR', 'M+', 'M-', 'MS']
            onButtonClicked: zone.appendToTextField(strToAppend)
        }

        ButtonsView {
            id: buttons
            Layout.fillWidth: true
            Layout.fillHeight: true
            labels: ['AC/C', '%', '←', '÷', '7', '8', '9', '×', '4', '5', '6', '−', '1', '2', '3', '+', '0', '.', '()', '=']
            targets: ['AC/C', '%', 'BACK', '/', '7', '8', '9', '*', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '()', '=']
            onButtonClicked: zone.appendToTextField(strToAppend)
        }
    }

    function calculate(evalText) {
        var res = calcEngine.eval(evalText)
        return res
    }
}
