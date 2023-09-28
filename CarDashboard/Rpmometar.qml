import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: id_root_rpm
    property double revs: 1000
    width:parent.width/1.2
    height:parent.height/1.2
    anchors.centerIn: parent


    Canvas {
        id:outerArc
        property int numberOfSpeeds: 8

        property int startAngle: 164

        property double angleLength: 25.71428

        anchors.centerIn: parent
        height: Math.min(id_root_rpm.width, id_root_rpm.height)
        width: height
        rotation: 75
        antialiasing: true
        onPaint: {
            var context1 = outerArc.getContext('2d');
            context1.strokeStyle = "white";
            context1.lineWidth = height * 0.01;
            context1.beginPath();
            context1.arc(width / 2, height / 2, 0.45*height, 0, Math.PI, false);
            context1.stroke();
        }
    }

    Canvas {
        id:innerArc
        anchors.centerIn: parent
        height: Math.min(id_root_rpm.width, id_root_rpm.height)
        width: height
        rotation: 75
        antialiasing: true
        onPaint: {
            var context = innerArc.getContext('2d');
            context.strokeStyle = "#404142";
            context.lineWidth = height * 0.1;
            context.beginPath();
            context.arc(outerArc.width / 2, outerArc.height / 2, outerArc.height / 2 - outerArc.height * 0.15, 0, Math.PI, false);
            context.stroke();
        }
    }

    Repeater {
        model: outerArc.numberOfSpeeds
        Item {
            height: 0.86*outerArc.height
            transformOrigin: Item.Center
            rotation: index * outerArc.angleLength + outerArc.startAngle
            x:parent.width/2
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: outerArc.horizontalCenter

            Rectangle {
                height: outerArc.height * 0.02
                width:height
                radius: width/2
                color: "white"
                antialiasing: true
            }

            Text {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                x: 0
                y: -outerArc.height * 0.15
                color: "white"
                rotation: 360 - (index * outerArc.angleLength + outerArc.startAngle)
                text: index
                font.pixelSize: outerArc.height * 0.05
                font.family: "Comic Sans MS"
            }


        }
    }

    Rectangle {
        id: id_center
        anchors.centerIn: parent
        height: outerArc.height*0.3
        width: height
        radius: width/2
        color: "#5e5f60"

        //isto ovdje malo srediti velicine
        ColumnLayout {
            anchors.centerIn: parent

            Text {
                text: "RPM"
                color: "white"
                font.pixelSize: parent.height * 0.15
                font.family: "Comic Sans MS"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "X1000"
                color: "white"
                font.pixelSize: parent.height * 0.15
                font.family: "Comic Sans MS"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text:  Math.floor(revs)
                color: "white"
                font.pixelSize: parent.height * 0.35
                font.family: "Comic Sans MS"
                Layout.alignment: Qt.AlignHCenter
            }

        }
    }

    Item {
        id: id_needle
        width:parent.width
        height:parent.height
        property int startAngle : 164
        property double angleLength: 0
        property int maxSpeed: 0
        anchors.top: outerArc.top
        anchors.bottom: outerArc.bottom
        rotation: revs * 0.026 + 164


        Rectangle {
            width: id_needle.height * 0.01
            height: id_needle.height * 0.25
            color: "#e01a1a"
            anchors {
                horizontalCenter: id_needle.horizontalCenter
            }
            antialiasing: true
            y: id_needle.height * 0.1
        }

        states: [
            State {
                name: "1st"
                when: velocity > 0 &&  velocity < 15
                PropertyChanges { target: id_root_rpm; revs: 100 * velocity + 1000  }

            },
            State {
                name: "2nd"
                when: velocity >= 15 && velocity < 25
                PropertyChanges { target: id_root_rpm; revs: 150 * velocity - 1250 }
            },
            State {
                name: "3rd"
                when: velocity >= 25 &&  velocity < 45
                PropertyChanges { target: id_root_rpm; revs: 75 * velocity - 875 }
            },
            State {
                name: "4th"
                when: velocity >= 45 &&  velocity < 65
                PropertyChanges { target: id_root_rpm; revs: 75 * velocity - 2375 }
            },
            State {
                name: "5th"
                when: velocity >= 65
                PropertyChanges { target: id_root_rpm; revs: 38.709 * velocity -1516.129  }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "1st"
                PropertyAnimation { properties: "revs"; duration: 800 }
            },
            Transition {
                from: "*"
                to: "2nd"
                PropertyAnimation { properties: "revs"; duration: 800 }
            },
            Transition {
                from: "*"
                to: "3rd"
                PropertyAnimation { properties: "revs"; duration: 800 }
            },
            Transition {
                from: "*"
                to: "4th"
                PropertyAnimation { properties: "revs"; duration: 800 }
            },
            Transition {
                from: "*"
                to: "5th"
                PropertyAnimation { properties: "revs"; duration: 800 }
            }
        ]

        antialiasing: true


    }


}
