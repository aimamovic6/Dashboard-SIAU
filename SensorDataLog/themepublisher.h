#ifndef THEMEPUBLISHER_H
#define THEMEPUBLISHER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QStringList>
#include <QtMqtt/QtMqtt>
#include <QtMqtt/QMqttClient>

struct Theme {
    QString topic;
    int message;
};

class ThemePublisher : public QObject {
    Q_OBJECT

public:
    ThemePublisher(const QString& fileName, QMqttClient* mqttClient);

public slots:
    void publishThemes();

private:
    QString fileName;
    QTimer* timer;
    QMqttClient* mqttClient;
    int cnt = 0;
};

#endif // THEMEPUBLISHER_H
