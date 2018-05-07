import QtQuick 2.6
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 424
    title: qsTr("Photoshop CC 2016")
    property string username: "User"

    Component.onCompleted: {
        hiObject.start()
    }

    Rectangle {
        width: parent.width
        height: parent.height

        Rectangle {
            z: 0
            width: parent.width
            height: parent.height

            Image {
                width: parent.width
                height: parent.height
                source: "../images/time.jpg"
            }

        }

        Rectangle {
            z: 1
            width: parent.width
            height: parent.height
            color: "Transparent"

            Text {
                anchors.centerIn: parent
                text: "Hi, " + username
                font.family: "Segoe UI"
                font.pixelSize: 72
                color: "white"
            }

        }

    }


    Connections {
        target: hiObject

        onStartUp: {
            username = start
        }
    }


}
