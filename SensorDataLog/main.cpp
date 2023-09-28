#include <QCoreApplication>
#include "themepublisher.h"



int main(int argc, char* argv[]) {
    QCoreApplication a(argc, argv);
    const QHostAddress address = QHostAddress::LocalHost;
    //    const QHostAddress address1 = QHostAddress("broker.hivemq.com");

    QMqttClient client;
    client.setHostname(address.toString());
    client.setPort(1883);
    client.connectToHost();


    ThemePublisher themePublisher("D:/fax/IV/siau/DashboardProject/SensorDataLog/teme.txt", &client);
    return a.exec();
}

