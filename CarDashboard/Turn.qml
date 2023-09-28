import QtQuick 2.0

Item {
    id: id_root

    width:parent.width/3
    height:parent.height/3
    anchors.centerIn: parent

    property bool isActive: false

    onIsActiveChanged: {
        triangle.requestPaint()
    }

    Canvas {
        id: triangle
        anchors.fill: parent
        anchors.centerIn: parent
        height: Math.min(id_root.width, id_root.height)
        width: height
        contextType: "2d"
        antialiasing: true

        onPaint: {
            var context = triangle.getContext('2d');

            if(id_root.isActive) context.fillStyle = "light green"
            else context.fillStyle = "grey"

            context.beginPath()
            context.moveTo(0, id_root.height / 2)
            context.lineTo(id_root.width / 3, 0)
            context.lineTo(id_root.width / 3, id_root.height)
            context.lineTo(0, id_root.height / 2)
            context.closePath()

            context.fill()
        }


    }

    Rectangle {
        id: id_rec
        height: Math.min(id_root.width/2, id_root.height/2)
        width: height
        anchors {
            left: id_root.left
            leftMargin: id_root.width / 3.1
            verticalCenter: id_root.verticalCenter
            right: id_root.right
        }
        color: isActive ? "light green" : "grey"
    }
}
