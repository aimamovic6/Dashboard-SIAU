import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

Item {
    id: id_root


    width:parent.width/1.2
    height:parent.height/1.2
    anchors.centerIn: parent
    property int gear: 0

    Canvas {
        id:outerArc
        property int numberOfSpeeds: 12
        property int startAngle: 223
        property double angleLength: 24.545454
        property int maxSpeed: 220

        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        rotation: 135
        antialiasing: true
        onPaint: {
            var context1 = outerArc.getContext('2d');
            context1.strokeStyle = "white";
            context1.lineWidth = height * 0.01;
            context1.beginPath();
            context1.arc(width / 2, height / 2, 0.45*height, 0, Math.PI*1.5, false);
            context1.stroke();
        }
    }

    Canvas {
        id:innerArc
        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        rotation: 135
        antialiasing: true
        onPaint: {
            var context = innerArc.getContext('2d');
            context.strokeStyle = "#404142";
            context.lineWidth = height * 0.1;
            context.beginPath();
            context.arc(outerArc.width / 2, outerArc.height / 2, outerArc.height / 2 - outerArc.height * 0.15, 0, Math.PI*1.5, false);
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
                text: index * (outerArc.maxSpeed / (outerArc.numberOfSpeeds - 1))
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
        ColumnLayout {
            anchors.centerIn: parent

            Text {
                text: "KPH"
                color: "white"
                font.pointSize: 15
                font.family: "Helvetica"
                Layout.alignment: Qt.AlignHCenter

            }

            Text {
                text: velocity
                color: "white"
                font.pointSize: 10
                font.family: "Arial"
                Layout.alignment: Qt.AlignHCenter
            }

        }
    }


    Item {
        id: id_needle
        width:parent.width
        height:parent.height

        property int startAngle : 223
        property double angleLength: 0
        property int maxSpeed: 0
        anchors.top: outerArc.top
        anchors.bottom: outerArc.bottom


        Rectangle {
            width: id_needle.height * 0.01
            height: id_needle.height * 0.25
            color: "#e01010"
            rotation: 0
            anchors {
                horizontalCenter: id_needle.horizontalCenter
            }
            antialiasing: true
            y: id_needle.height * 0.1
        }
        rotation: velocity * 1.22727 - 135
//        rotation: speedClient.value
        antialiasing: true


    }

    Image {
        id: gearBox
        source: ""

        anchors.bottom:outerArc.bottom

        anchors.horizontalCenter: parent.horizontalCenter
        width:outerArc.width/6
        height:width

        states: [
            State {
                name: "1st"
                when: velocity > 0 &&  velocity < 15
                PropertyChanges { target: gearBox; source: "images/gearbox_visual_1.png" ;}
                PropertyChanges { target: id_root; gear: 1 }

            },
            State {
                name: "2nd"
                when: velocity >= 15 && velocity < 25
                PropertyChanges { target: gearBox; source: "images/gearbox_visual_2.png" }
                PropertyChanges { target: id_root; gear: 2 }
            },
            State {
                name: "3rd"
                when: velocity >= 25 &&  velocity < 45
                PropertyChanges { target: gearBox; source: "images/gearbox_visual_3.png" }
                PropertyChanges { target: id_root; gear: 3 }
            },
            State {
                name: "4th"
                when: velocity >= 45 &&  velocity < 65
                PropertyChanges { target: gearBox; source: "images/gearbox_visual_4.png" }
                PropertyChanges { target: id_root; gear: 4 }
            },
            State {
                name: "5th"
                when: velocity >= 65
                PropertyChanges { target: gearBox; source: "images/gearbox_visual_5.png" }
                PropertyChanges { target: id_root; gear: 5 }
            }
        ]


        transitions: [
            Transition {
                from: "*"
                to: "1st"
                PropertyAnimation { properties: "source"; duration: 300 }
            },
            Transition {
                from: "*"
                to: "2nd"
                PropertyAnimation { properties: "source"; duration: 300 }
            },
            Transition {
                from: "*"
                to: "3rd"
                PropertyAnimation { properties: "source"; duration: 300 }
            },
            Transition {
                from: "*"
                to: "4th"
                PropertyAnimation { properties: "source"; duration: 300 }
            },
            Transition {
                from: "*"
                to: "5th"
                PropertyAnimation { properties: "source"; duration: 300 }
            }
        ]
    }




}
