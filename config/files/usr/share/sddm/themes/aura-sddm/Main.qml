// Copyright 2022 Alexey Varfolomeev <varlesh@gmail.com>
// Used sources & ideas:
// - Joshua Krämer from https://github.com/joshuakraemer/sddm-theme-dialog
// - Suraj Mandal from https://github.com/surajmandalcell/Elegant-sddm
// - Breeze theme by KDE Visual Design Group
// - SDDM Team https://github.com/sddm/sddm
import QtQuick 2.8
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.1
import "components"

Rectangle {
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants {
        id: textConstants
    }

    // hack for disable autostart QtQuick.VirtualKeyboard
    Loader {
        id: inputPanel
        property bool keyboardActive: false
        source: "components/VirtualKeyboard.qml"
    }

    Connections {
        target: sddm
        onLoginSucceeded: {

        }
        onLoginFailed: {
            password.placeholderText = textConstants.loginFailed
            password.placeholderTextColor = "#f44336"
            password.text = ""
            password.focus = true
            errorMsgContainer.visible = true
        }
    }

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        Binding on source {
            when: config.background !== undefined
            value: config.background
        }
    }
    GaussianBlur {
        anchors.fill: background
        source: background
        radius: 30
        samples: 60
    }

    Rectangle {
        id: panel
        color: "#454545"
        radius: 40
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }

    DropShadow {
        anchors.fill: panel
        horizontalOffset: 0
        verticalOffset: 0
        radius: 40.0
        samples: 17
        color: "#70000000"
        source: panel
        }
    
    Row {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.topMargin: 20

        Item {

            Image {
                id: shutdown
                height: 32
                width: 32
                source: "images/system-shutdown.svg"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        shutdown.source = "images/system-shutdown-hover.svg"
                    }
                    onExited: {
                        shutdown.source = "images/system-shutdown.svg"
                    }
                    onClicked: {
                        shutdown.source = "images/system-shutdown-pressed.svg"
                        sddm.powerOff()
                    }
                }
            }
        }
    }

    Row {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 85
        anchors.topMargin: 20

        Item {

            Image {
                id: reboot
                height: 32
                width: 32
                source: "images/system-reboot.svg"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        reboot.source = "images/system-reboot-hover.svg"
                    }
                    onExited: {
                        reboot.source = "images/system-reboot.svg"
                    }
                    onClicked: {
                        reboot.source = "images/system-reboot-pressed.svg"
                        sddm.reboot()
                    }
                }
            }
        }
    }

    Row {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 14
        Text {
            id: timelb
            text: Qt.formatDateTime(new Date(), "dddd, d MMMM. h:mm AP")
            color: "#dfdfdf"
            font.pointSize: 18
        }
    }

    Timer {
        id: timetr
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            timelb.text = Qt.formatDateTime(new Date(), "dddd, d MMMM. h:mm AP")
        }
    }
    Row {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 130
        anchors.topMargin: 14
        Text {
            id: kb
            color: "#dfdfdf"
            text: keyboard.layouts[keyboard.currentLayout].shortName
            font.pointSize: 18
        }
    }

    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 24
        anchors.topMargin: 14
        Text {
            id: welcome
            text: textConstants.welcomeText.arg(sddm.hostName)
            color: "#dfdfdf"
            font.pointSize: 18
        }
    }

    Item {
        anchors.centerIn: parent
        width: dialog.width
        height: dialog.height
        Material.theme: Material.Dark
        Material.accent: "#048bd4"

        Rectangle {
            id: dialog
            color: "#454545"
            radius: 20
            anchors.centerIn: parent
            height: 650
            width: 600
        }
            
            DropShadow {
            anchors.fill: dialog
            horizontalOffset: 0
            verticalOffset: 6
            radius: 20.0
            samples: 17
            color: "#40000000"
            source: dialog
        }

            Grid {
                columns: 1
                spacing: 20
                leftPadding: 25
                topPadding: 35
                verticalItemAlignment: Grid.AlignVCenter
                horizontalItemAlignment: Grid.AlignHCenter

                Column {
                    Item {

                        Rectangle {
                            id: mask
                            width: 200
                            height: 200
                            radius: 100
                            visible: false
                        }

                        DropShadow {
                            anchors.fill: mask
                            width: mask.width
                            height: mask.height
                            horizontalOffset: 0
                            verticalOffset: 0
                            radius: 15.0
                            samples: 15
                            color: "#50000000"
                            source: mask
                        }
                    }

                    Image {
                        id: ava
                        width: 200
                        height: 200
                        fillMode: Image.PreserveAspectCrop
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: mask
                        }
                        source: "/var/lib/AccountsService/icons/" + user.currentText
                        onStatusChanged: {
                            if (status == Image.Error)
                                return source = "images/.face.icon"
                        }
                    }
                }

                // Custom ComboBox for hack colors on DropDownMenu
                ComboBox {
                    id: user
                    height: 70
                    width: height * 8
                    model: userModel
                    font.pointSize: 18
                    textRole: "name"
                    currentIndex: userModel.lastIndex

                    delegate: MenuItem {
                        Material.theme: Material.Dark
                        Material.accent: "#048bd4"
                        width: ulistview.width
                        text: user.textRole ? (Array.isArray(
                                                   user.model) ? modelData[user.textRole] : model[user.textRole]) : modelData
                        Material.foreground: user.currentIndex === index ? ulistview.contentItem.Material.accent : ulistview.contentItem.Material.foreground
                        highlighted: user.highlightedIndex === index
                        hoverEnabled: user.hoverEnabled
                        font.pointSize: 18
                        onClicked: {
                            user.currentIndex = index
                            ulistview.currentIndex = index
                            user.popup.close()
                            ava.source = ""
                            ava.source = "/var/lib/AccountsService/icons/" + user.currentText
                        }
                    }
                    popup: Popup {
                        Material.theme: Material.Dark
                        Material.accent: "#ffffff"
                        width: parent.width
                        font.pointSize: 18
                        height: parent.height * parent.count
                        implicitHeight: ulistview.contentHeight
                        margins: 0
                        contentItem: ListView {
                            id: ulistview
                            clip: true
                            anchors.fill: parent
                            model: user.model
                            spacing: 0
                            highlightFollowsCurrentItem: true
                            currentIndex: user.highlightedIndex
                            delegate: user.delegate
                        }
                    }
                }

                TextField {
                    id: password
                    height: 70
                    width: height * 8
                    font.pointSize: 18
                    echoMode: TextInput.Password
                    focus: true
                    placeholderText: textConstants.password
                    onAccepted: sddm.login(user.currentText, password.text,
                                           session.currentIndex)
                    Image {
                        id: caps
                        width: 24
                        height: 24
                        opacity: 0
                        state: keyboard.capsLock ? "activated" : ""
                        anchors.right: password.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10
                        fillMode: Image.PreserveAspectFit
                        source: "images/capslock.svg"
                        sourceSize.width: 24
                        sourceSize.height: 24

                        states: [
                            State {
                                name: "activated"
                                PropertyChanges {
                                    target: caps
                                    opacity: 1
                                }
                            },
                            State {
                                name: ""
                                PropertyChanges {
                                    target: caps
                                    opacity: 0
                                }
                            }
                        ]

                        transitions: [
                            Transition {
                                to: "activated"
                                NumberAnimation {
                                    target: caps
                                    property: "opacity"
                                    from: 0
                                    to: 1
                                    duration: imageFadeIn
                                }
                            },

                            Transition {
                                to: ""
                                NumberAnimation {
                                    target: caps
                                    property: "opacity"
                                    from: 1
                                    to: 0
                                    duration: imageFadeOut
                                }
                            }
                        ]
                    }
                }

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return
                            || event.key === Qt.Key_Enter) {
                        sddm.login(user.currentText, password.text,
                                   session.currentIndex)
                        event.accepted = true
                    }
                }

                // Custom ComboBox for hack colors on DropDownMenu
                ComboBox {
                    id: session
                    height: 70
                    width: height * 8
                    font.pointSize: 18
                    model: sessionModel
                    textRole: "name"
                    currentIndex: sessionModel.lastIndex

                    delegate: MenuItem {
                        Material.theme: Material.Dark
                        Material.accent: "#048bd4"
                        width: slistview.width
                        font.pointSize: 18
                        text: session.textRole ? (Array.isArray(
                                                      session.model) ? modelData[session.textRole] : model[session.textRole]) : modelData
                        Material.foreground: session.currentIndex === index ? slistview.contentItem.Material.accent : slistview.contentItem.Material.foreground
                        highlighted: session.highlightedIndex === index
                        hoverEnabled: session.hoverEnabled
                        onClicked: {
                            session.currentIndex = index
                            slistview.currentIndex = index
                            session.popup.close()
                        }
                    }
                    popup: Popup {
                        Material.theme: Material.Dark
                        Material.accent: "#ffffff"
                        width: parent.width
                        height: parent.height * parent.count
                        implicitHeight: slistview.contentHeight
                        margins: 0
                        contentItem: ListView {
                            id: slistview
                            clip: true
                            anchors.fill: parent
                            model: session.model
                            spacing: 0
                            highlightFollowsCurrentItem: true
                            currentIndex: session.highlightedIndex
                            delegate: session.delegate
                        }
                    }
                }

                Button {
                    id: login

                    height: 70
                    width: height * 8
                    font.pointSize: 18
                    icon.source: "images/login.svg"
                    icon.width: 24
                    icon.height: 24
                    text: textConstants.login
                    font.bold: true
                    onClicked: sddm.login(user.currentText, password.text,
                                          session.currentIndex)
                    highlighted: true
                }
            }
    }
}
