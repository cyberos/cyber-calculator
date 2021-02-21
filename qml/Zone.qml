import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import MeuiKit 1.0 as Meui
import org.cyber.calculator 1.0

Item {
    id: zone

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: 0

        ListView {
            id: listView
            model: ListModel { id: historyModel }
            clip: true

            Layout.fillHeight: true
            Layout.fillWidth: true

            flickableDirection: Flickable.VerticalFlick
            ScrollBar.vertical: ScrollBar {}

            onCountChanged: {
                listView.currentIndex = count - 1
            }

            delegate: Item {
                height: label.implicitHeight + Meui.Units.largeSpacing * 2
                width: parent ? parent.width : undefined

                Label {
                    id: label
                    anchors.fill: parent
                    horizontalAlignment: Qt.AlignRight
                    text: historyModel.get(index).text
                    elide: Text.ElideMiddle
                    color: Meui.Theme.disabledTextColor

                    leftPadding: Meui.Units.largeSpacing
                    rightPadding: Meui.Units.largeSpacing

                    MouseArea {
                        hoverEnabled: true
                    }
                }
            }
        }

        CTextField {
            id: textField
            height: 50
            Layout.fillWidth: true
            Keys.onReturnPressed: appendToTextField('=')
            Keys.onEnterPressed: appendToTextField('=')

            leftPadding: Meui.Units.largeSpacing
            rightPadding: Meui.Units.largeSpacing
        }
    }

    Memory {
        id: memory
        onFailed: {
            toast.text = errorString
            toast.open = true
        }
    }
    
    Meui.Toast {
        id: toast
    }

    function appendToTextField(text) {
        if (text === '=') {
            var res = calculate(textField.text)
            if (res !== '') {
                var expressionText = textField.text
                textField.text = res;

                // If the expression and the result area equal,
                // it will not be added to the ListView
                if (expressionText !== res) {
                    expressionText = expressionText + " = " + res
                    historyModel.append({"text": expressionText})
                }
            }
        } else if (text === 'AC/C') {
            if (textField.text != "")
                textField.clear()
            else 
                historyModel.clear()
        } else if (text === 'BACK') {
            // backspace
            textField.remove(textField.cursorPosition, textField.cursorPosition - 1)
        } else if (text.startsWith('M')) {
            switch(text) {
                case 'MC':
                    memory.text = ""
                    break
                case 'MR':
                    textField.insert(textField.cursorPosition, memory.text)
                    break
                case 'M+':
                    memory.increase(textField.text)
                    break
                case 'M-':
                    memory.decrease(textField.text)
                    break
                case 'MS':
                    var res = calculate(textField.text)
                    if (res == "") break
                    memory.text = res
                    break
            }
        } else {
            textField.insert(textField.cursorPosition, text)
        }
    }
}
