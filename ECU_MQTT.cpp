#include "mbed.h"
#include "MQTTNetwork.h"
#include "MQTTmbed.h"
#include "MQTTClient.h"

NetworkInterface* net;

void messageArrivedSpeed(MQTT::MessageData& md);
void messageArrivedBrake(MQTT::MessageData& md);
void messageArrivedSeat(MQTT::MessageData& md);
void messageArrivedBelt(MQTT::MessageData& md);
void messageArrivedHazard(MQTT::MessageData& md);
void messageArrivedLeft(MQTT::MessageData& md);
void messageArrivedRight(MQTT::MessageData& md);
void messageArrivedFuel(MQTT::MessageData& md);


int main() {

    net = NetworkInterface::get_default_instance();
    if (!net) {
        printf("Error! No network interface found.\n");
        return 0;
    }

    int ret = net->connect();
    if (ret != 0) {
        printf("Error! net->connect() returned: %d\n", ret);
        return 0;
    }

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> client(mqttNetwork);

    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    int rc = mqttNetwork.connect(hostname, port);
    if (rc != 0) {
        printf("rc from TCP connect is %d\r\n", rc);
        return -1;
    }

    
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "sensorReader";
    rc = client.connect(data);
    if (rc != 0) {
        printf("rc from MQTT connect is %d\r\n", rc);
        return -1;
    }

    
    client.subscribe("speed", MQTT::QOS0, messageArrivedSpeed);
    client.subscribe("parkBrake", MQTT::QOS0, messageArrivedBrake);
    client.subscribe("seatSensor", MQTT::QOS0, messageArrivedSeat);
    client.subscribe("beltSensor", MQTT::QOS0, messageArrivedBelt);
    client.subscribe("hazardInd", MQTT::QOS0, messageArrivedHazard);
    client.subscribe("leftInd", MQTT::QOS0, messageArrivedLeft);
    client.subscribe("rightInd", MQTT::QOS0, messageArrivedRight);
    client.subscribe("fuel", MQTT::QOS0, messageArrivedFuel);

    while (true) {
        client.yield(1000);
    }
    
    client.disconnect();
    mqttNetwork.disconnect();

    
    net->disconnect();
    return 0;
}

void messageArrivedSpeed(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float vel = receivedSpeed * 0.14733;
    float angle = vel * 1.22727 - 135
    
    char buffer[20];
    sprintf(buffer, "%.2f", angle);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "speed_multiplier";
    pubClient.connect(data);

    pubClient.publish("speed2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedBrake(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "brake_cl";
    pubClient.connect(data);

    pubClient.publish("brake2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedSeat(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "seat_cl";
    pubClient.connect(data);

    pubClient.publish("seat2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedBelt(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "belt_cl";
    pubClient.connect(data);

    pubClient.publish("belt2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedHazard(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "hazard_cl";
    pubClient.connect(data);

    pubClient.publish("hazard2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedLeft(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "left_cl";
    pubClient.connect(data);

    pubClient.publish("left2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedRight(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedSpeed = atof((char*)message.payload);
    
    float doubledSpeed = receivedSpeed * 2;
    
    char buffer[20];
    sprintf(buffer, "%.2f", doubledSpeed);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "right_cl";
    pubClient.connect(data);

    pubClient.publish("right2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}

void messageArrivedFuel(MQTT::MessageData& md) {
    MQTT::Message &message = md.message;
    float receivedFuel = atof((char*)message.payload);
    
    float level = receivedFuel * 0.0625 - 25;
    float angle = -1.8 * level  + 195
    
    char buffer[20];
    sprintf(buffer, "%.2f", angle);

    MQTT::Message newMessage;
    newMessage.qos = MQTT::QOS0;
    newMessage.retained = false;
    newMessage.dup = false;
    newMessage.payload = (void*)buffer;
    newMessage.payloadlen = strlen(buffer);

    MQTTNetwork mqttNetwork(net);
    MQTT::Client<MQTTNetwork, Countdown> pubClient(mqttNetwork);
    
    const char* hostname = "broker.hivemq.com";
    int port = 1883;
    mqttNetwork.connect(hostname, port);
    MQTTPacket_connectData data = MQTTPacket_connectData_initializer;
    data.MQTTVersion = 3;
    data.clientID.cstring = "fuel_cl";
    pubClient.connect(data);

    pubClient.publish("fuel2", newMessage);
    
    pubClient.disconnect();
    mqttNetwork.disconnect();
}