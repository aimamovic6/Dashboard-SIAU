import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.5
import QmlClient 1.0

Window {
    visible: true
    title: qsTr("Dashboard")
    color:"#000000"
    width: Screen.width *0.6
    height: Screen.height * 0.6
    minimumHeight: Screen.height * 0.5
    minimumWidth: Screen.width *0.5

    property int velocity: speedClient.value  * 0.14733
    property double fuellevel: fuelClient.value * 0.0625 - 25

    QmlClient {
    id : speedClient
    topic: "speed"
    onValueChanged:{
        speedClient.setValue(newValue)
        }
    }
    QmlClient{
        id: brakeClient
        topic: "parkBrake"
        onValueChanged: {
            brakeClient.setValue(newValue)
        }
    }

    QmlClient {
        id : seatClient
        topic: "seatSensor"
        onValueChanged: {
            seatClient.setValue(newValue)
        }
    }

    QmlClient {
        id : beltClient
        topic: "beltSensor"
        onValueChanged: {
            beltClient.setValue(newValue)
        }
    }

    QmlClient {
        id : hazardClient
        topic: "hazardInd"
        onValueChanged: {
            hazardClient.setValue(newValue)
        }
    }

    QmlClient {
        id : leftClient
        topic: "leftInd"
        onValueChanged: {
            leftClient.setValue(newValue)
        }
    }

    QmlClient {
        id : rightClient
        topic: "rightInd"
        onValueChanged: {
            rightClient.setValue(newValue)
        }
    }

    QmlClient {
        id : fuelClient
        topic: "fuel"
        onValueChanged: {
            fuelClient.setValue(newValue)
        }
    }


    Component.onCompleted: {
        speedClient.connectAndSub()
        brakeClient.connectAndSub()
        seatClient.connectAndSub()
        beltClient.connectAndSub()
        hazardClient.connectAndSub()
        leftClient.connectAndSub()
        rightClient.connectAndSub()
        fuelClient.connectAndSub()
    }


    Item {

        id:mainDashboard
        anchors.fill: parent
        anchors.bottomMargin: parent.height/5


        Item {
            anchors.fill: parent
            anchors.rightMargin: 2*parent.width/3

            Rpmometar {
                id:rpm
            }
            Item {
                id: turnLeftitem
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: parent.height/10
                width: parent.width/5
                height: parent.height/10
                Turn{
                    anchors.fill: parent
                    isActive: false
                    //anchors.bottomMargin: 54

                    id: turnl


                }

                Timer {
                    id: timer_left_ind
                    interval: 500;
//                    running: left_indicator.checked | hazard_light.checked;
                    running: leftClient.value === 1 | hazardClient.value === 1
                    repeat: true
                    onTriggered: {
                        if ( !turnl.isActive ) turnl.isActive = true
                        else turnl.isActive = false;


                    }
                    onRunningChanged: {turnl.isActive = false;

                    }

                }
            }
        }

        Item {
            anchors.fill: parent
            anchors.leftMargin: parent.width/3
            anchors.rightMargin: parent.width/3
            PraviSpeed {
                id:speed
            }


        }

        Item {
            anchors.fill: parent
            anchors.leftMargin: 2*parent.width/3

            FuelGauge {
                id:fuel
            }

            Item {
                id: turnRightitem
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: parent.height/10
                width: parent.width/5
                height: parent.height/10
                rotation: 180
                Turn{
                    anchors.fill: parent
                    id: turnr


                }

                Timer {
                    id: timer_right_ind
                    interval: 500;
//                    running: right_indicator.checked | hazard_light.checked;
                    running: rightClient.value === 1 |  hazardClient.value === 1
                    repeat: true
                    onTriggered: {
                        if ( !turnr.isActive ) turnr.isActive = true
                        else turnr.isActive = false;
                    }
                    onRunningChanged: turnr.isActive = false;
                }
            }

        }

    }

    Item {
        id:icons
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        height:parent.height/6
        width:parent.width/2
        anchors {
            verticalCenter: mainDashboard.bottom
        }

        RowLayout {
            id: row
            anchors.fill:parent
            //rows:1
            //columns:5

            Image {
                id: image1
                source:  brakeClient.value === 1 ? "icons/rucnaon.png" : "icons/rucnaoff.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7
            }

            Image {
                id: image2
                source: seatClient.value ===1 && beltClient.value != 1 ? "icons/pojason.png" : "icons/pojasoff.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7
            }
            Image {
                id: image3
                source: "icons/absoff.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7
            }
            Image {
                id: image4
                source: "icons/engineoff.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7

            }
            Image {
                id: image5
                source: fuellevel > 10 ? "icons/fueloff.png" : "icons/fuelon.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7
            }
            Image {
                id: image6
                source:  hazardClient.value ===1 ? "icons/blinkeron.png" : "icons/blinkeroff.png"
                Layout.preferredWidth: parent.width/7
                Layout.preferredHeight: parent.width/7
            }

        }
    }


}

