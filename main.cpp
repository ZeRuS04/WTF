#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "gamelogic.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    GameLogic logic;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("log", &logic);
    engine.load(QUrl(QStringLiteral("qrc:///Main.qml")));

    return app.exec();
}
