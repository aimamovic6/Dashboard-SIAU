#include "qmlclient.h"

QmlClient::QmlClient(QObject *parent) : QMqttClient(parent), m_client(new QMqttClient(this)) {
    const QHostAddress address = QHostAddress::LocalHost;
//    const QHostAddress address = QHostAddress("broker.hivemq.com");
    m_client->setHostname(address.toString());
    m_client->setPort(1883);
    m_client->connectToHost();
}

void QmlClient::connectAndSub()
{
    QObject::connect(m_client, &QMqttClient::stateChanged, [&]() {
        if (m_client->state() == QMqttClient::Connected) {
            m_sub =  m_client->subscribe(QMqttTopicFilter(m_topic));
            if (m_sub == nullptr) {
                qDebug() <<"Error: nullptr!";
            } else {
                QObject::connect(m_sub, &QMqttSubscription::messageReceived, this, &QmlClient::updateValue );
            }
        }
    });

}

int QmlClient::value()
{
    return m_value;
}

QString QmlClient::topic()
{
    return m_topic;
}

void QmlClient::setValue(int newValue)
{
    m_value = newValue;
}

void QmlClient::updateValue(const QMqttMessage &message)
{
    int newVal = message.payload().toFloat();
//    qDebug() <<newVal;
    emit valueChanged(newVal);
}
