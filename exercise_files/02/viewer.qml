import QtQuick 2.6
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 720
    height: 640
    color: "#000000"
    title: qsTr('Adobe After Effects')
    property string images: '[{"file": "images/flamingo.jpg"}]'
    property string filenames: '[{"flamingo.jpg": ["C:/images/love"] }]'
    property bool opened: false
    property string selected_file: ""
    property var allimages: []
    property var files: []

    RowLayout {

        width: parent.width
        height: parent.height

        ColumnLayout {
            id: drawerCont
            Layout.minimumWidth: 0
            Layout.maximumWidth: 320
            Layout.fillHeight: true
            visible: false

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#4C4A48"

                RowLayout {
                    width: parent.width
                    height: 36

                    Text {
                        color: "white"
                        text: "File Info"
                        font {
                            family: "Segoe UI, fonts/Roboto-Regular.ttf"
                            pixelSize: 20
                        }

                    }

                    Text {
                        anchors.right: parent.right
                        color: "white"
                        text: "close"
                        font {
                            family: "Segoe UI, fonts/Roboto-Regular.ttf"
                            pixelSize: 16
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                parent.color = "pink"
                            }

                            onPressed: {
                                if(opened === false) {
                                    drawerCont.visible = true
                                    drawerAnim.running = true
                                    opened = true
                                } else {
                                    reverseDrawerAnim.running = true
                                    opened = false
                                }
                            }

                            onExited: {
                                parent.color = "white"
                            }

                        }

                    }

                }

            }


        }


        ColumnLayout {
            id: screenCont
            Layout.fillWidth: true
            Layout.minimumWidth: 640
            Layout.fillHeight: true
            spacing: 0

            Rectangle {
                id: navCont
                Layout.fillWidth: true
                height: 48
                visible: true
                color: "black"

                RowLayout {
                    width: parent.width
                    height: parent.height

                    Rectangle {
                        Layout.preferredWidth: 200
                        //width: children[0].width
                        Layout.fillHeight: true
                        color: "#9BCC29"

                        Text {
                            width: parent.width
                            elide: Text.ElideRight
                            padding: 8
                            color: "white"
                            text: selected_file.toUpperCase()
                            anchors.verticalCenter: parent.verticalCenter
                            font {
                                family: "fonts/Roboto-Thin.ttf"
                                pixelSize: 16
                            }
                        }

                    }

                    Rectangle {
                        anchors.right: parent.right
                        width: 72
                        Layout.fillHeight: true
                        color: "black"

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                parent.color = "#ccc"
                            }

                            onPressed: {
                                if(opened === false) {
                                    drawerCont.visible = true
                                    drawerAnim.running = true
                                    opened = true
                                } else {
                                    reverseDrawerAnim.running = true
                                    opened = false
                                }
                            }

                            onExited: {
                                parent.color = "black"
                            }

                        }

                        Image {
                            anchors.centerIn: parent
                            width: 36
                            height: 36
                            source: "icons/ic_more_horiz_white_36dp.png"
                        }
                    }

                }

            }

            Rectangle {
                id: viewer
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true
                Layout.maximumWidth: 720
                Layout.fillHeight: true
                color: "#000000"

                Image {
                    id: preview
                    width: viewer.width
                    height: viewer.height
                    source: ""
                }

            }

            Rectangle {
                id: scrollCont
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true
                height: 120
                color: "#4C4A48"

                ListView {
                    id: lView
                    width: scrollCont.width
                    height: 120

                    Component.onCompleted: {
                        var all = JSON.parse(images);
                        allimages = all
                        var filename = JSON.parse(filenames);
                        files = filename
                        model.append(all);
                    }

                    ListModel {
                        id: lmodel
                        ListElement {
                            file: "images/car-repair.jpg"
                        }

                        ListElement {
                            file: "images/blueberries.jpg"
                        }
                    }

                    Component {
                        id: ld
                        Rectangle {
                            width: 160
                            height: 120
                            color: "Transparent"

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true

                                onEntered: {
                                    var eleX = parent.x
                                    var eleY = parent.y
                                    var eleIndex = lView.indexAt(eleX, eleY)
                                    lView.currentIndex = eleIndex
                                }

                                onClicked: {
                                    preview.source = parent.children[1].source
                                    var sel_file_path = lView.model.get(lView.currentIndex).file
                                    var splits = sel_file_path.split('/');
                                    selected_file = splits[1]
                                }
                            }

                            Image {
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width
                                height: 80
                                source: file
                            }
                        }
                    }

                    model: lmodel
                    orientation: Qt.Horizontal
                    highlight: Rectangle {color: "gold"; opacity: 0.7 }
                    highlightMoveDuration: -1
                    delegate: ld
                }

            }

        }




    }


    ParallelAnimation {
        id: drawerAnim


        NumberAnimation {
            target: screenCont
            property: "Layout.minimumWidth"
            from: window.width
            to: 640
            duration: 300
            easing.type: Easing.InQuad
        }


        NumberAnimation {
            target: drawerCont
            property: "Layout.minimumWidth"
            from: 0
            to: 320
            duration: 300
            easing.type: Easing.InQuad
        }

        XAnimator {
            target: drawerCont
            from: -320
            to: 0
            duration: 300
            easing.type: Easing.InQuad
        }

        running: false
    }

    ParallelAnimation {
        id: reverseDrawerAnim

        NumberAnimation {
            target: screenCont
            property: "Layout.minimumWidth"
            from: 640
            to: window.width
            duration: 300
            easing.type: Easing.InQuad
        }


        NumberAnimation {
            target: drawerCont
            property: "Layout.minimumWidth"
            from: 320
            to: 0
            duration: 300
            easing.type: Easing.InQuad
        }

        XAnimator {
            target: drawerCont
            from: 0
            to: -320
            duration: 300
            easing.type: Easing.InQuad
        }

        running: false

    }

}
