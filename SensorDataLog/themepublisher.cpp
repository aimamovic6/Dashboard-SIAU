#include "themepublisher.h"

ThemePublisher::ThemePublisher(const QString& fileName, QMqttClient* mqttClient) : QObject(), fileName(fileName), mqttClient(mqttClient) {
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &ThemePublisher::publishThemes);
    timer->start(10);
}

void ThemePublisher::publishThemes() {
    QFile inputFile(fileName);
    if (!inputFile.exists()){
        qCritical() << "File not found!";
        return;
    }

    if (!inputFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open input file.";
        return;
    }

    QTextStream in(&inputFile);

    while (!in.atEnd()) {
        in.seek(cnt++ * 96);
        if (cnt == 4600) cnt = 0;
        QString line = in.readLine();
        QStringList tokens = line.split(" ");

        for (int i = 0; i < tokens.size(); i += 2) {
            mqttClient->publish(QMqttTopicName(tokens[i]), QByteArray::number(tokens[i + 1].toFloat()), 0, false);
        }
        break;  // You may want to remove this line if you want to process all lines in the file.
    }

    inputFile.close();
}
