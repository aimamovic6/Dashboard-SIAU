#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMqttClient>
#include "qmlclient.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/CarDashboard/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    qmlRegisterType<QmlClient>("QmlClient", 1, 0, "QmlClient");
    engine.load(url);

    return app.exec();
}
