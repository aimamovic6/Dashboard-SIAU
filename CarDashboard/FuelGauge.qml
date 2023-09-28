import QtQuick 2.3
import QtQuick.Layouts 1.3

Item {
    id: id_root
    property int value: 0
    width:parent.width/1.2
    height:parent.height/1.2
    anchors.centerIn: parent

    Canvas {
        id:outerArc
        property int numberOfSpeeds: 5
        property int startAngle: 14

        property double angleLength: 45

        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        rotation: 285
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
        height: Math.min(id_root.width, id_root.height)
        width: height
        //anchors.fill: parent
        rotation: 285
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
                //width: !(index%2) ? height/2 : height/4
                width:height
                radius: width/2
                rotation: 1
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
                text: ["F", "","1/2", "","E"][index]
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
                text: "KMs left"
                color: "white"
                font.pixelSize: parent.height * 0.3
                font.family: "Comic Sans MS"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: Math.floor(fuellevel *3)
                color: "white"
                font.pixelSize: 13 //parent.height * 0.35
                font.family: "Comic Sans MS"
                Layout.alignment: Qt.AlignHCenter
            }

        }
    }

    Item {
        id: id_needle
        width:parent.width
        height:parent.height
        property int value: 0
        property int startAngle : 15
        property double angleLength: 0
        property int maxSpeed: 0
        anchors.top: outerArc.top
        anchors.bottom: outerArc.bottom

        Rectangle {
            width: id_needle.height * 0.01
            height: id_needle.height * 0.25
            color: "red"
            anchors {
                horizontalCenter: id_needle.horizontalCenter
            }
            antialiasing: true
            y: id_needle.height * 0.1
        }
        rotation: -1.8 * fuellevel  + 195
//        rotation: fuelClient.value



        antialiasing: true


    }
}
