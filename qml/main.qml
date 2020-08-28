import QtQuick 2.9
import QtQuick.Controls 2.5
import "../backend/math.js" as MathJs

ApplicationWindow {
    visible: true
    width: 350
    height: 550
    minimumWidth: 350
    minimumHeight: 550
    title: qsTr("Calculator")
    id: rootWindow

    property var mathJs: MathJs.mathJs
    property string lastError

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

    Component.onCompleted: {
        mathJs.config({
            number: 'BigNumber'
        });
    }

    function calculate(evalText) {
        try {
            var res = mathJs.eval(evalText)
        } catch (exception) {
            lastError = exception.toString();
            return ''
        }

        return res;
    }

}
