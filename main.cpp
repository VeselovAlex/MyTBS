#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(res);

    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/TBS/main.qml"));
    viewer.showExpanded();
    //viewer.showFullScreen();

    return app.exec();
}
