#ifndef QMLCLIENT_H
#define QMLCLIENT_H

#include <QMqttClient>
#include <QObject>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttMessage>
#include <QtMqtt/QMqttSubscription>
#include <QString>
class QmlClient : public QMqttClient
{
    Q_OBJECT
    Q_PROPERTY(int  value READ value WRITE setValue NOTIFY valueChanged FINAL)
    Q_PROPERTY(QString topic READ topic WRITE setTopic FINAL)
public:
    explicit QmlClient(QObject *parent = nullptr);
    Q_INVOKABLE void connectAndSub ();
    int value();
    QString topic();
    Q_INVOKABLE void setTopic(const QString &t){
        m_topic = t;
    }
public slots:
    void setValue(int newValue);
    void updateValue(const QMqttMessage &message );


signals:
    void valueChanged(int newValue);
private:
    int m_value = 0;
    QMqttClient * m_client;
    QMqttSubscription * m_sub = nullptr;
    QString m_topic = "";
};

#endif // QMLCLIENT_H
