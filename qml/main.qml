import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import org.cyber.calculator 1.0
import MeuiKit 1.0 as Meui

Meui.Window {
    visible: true
    width: 350
    height: 550
    minimumWidth: 350
    minimumHeight: 550
    title: qsTr("Calculator")
    id: rootWindow

    backgroundColor: Meui.Theme.secondBackgroundColor

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

        ButtonsView {
            id: buttons
            Layout.fillWidth: true
            Layout.fillHeight: true
            labels: ['AC', '%', '←', '÷', '7', '8', '9', '×', '4', '5', '6', '−', '1', '2', '3', '+', '0', '.', '()', '=']
            targets: ['AC', '%', 'BACK', '/', '7', '8', '9', '*', '4', '5', '6', '-', '1', '2', '3', '+', '0', '.', '()', '=']
            onButtonClicked: zone.appendToTextField(strToAppend)
        }
    }

    function calculate(evalText) {
        var res = calcEngine.eval(evalText)
        return res
    }

}
