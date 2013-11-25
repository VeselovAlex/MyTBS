#ifndef GAMEDATAFILE_H
#define GAMEDATAFILE_H

#include <QObject>
#include <fstream>
using namespace std;

class GameDataFile : public QObject
{
    Q_OBJECT
public:
    explicit GameDataFile(QObject *parent = 0);
    Q_INVOKABLE void loadFileForWriting(QString filename);
    Q_INVOKABLE void write(QString data);
    Q_INVOKABLE void loadFileForReading(QString filename);
    Q_INVOKABLE QString read();
    Q_INVOKABLE void close();
    ~GameDataFile();
signals:
    bool opened();
    bool error();
private:
    ofstream ostream;
    ifstream istream;

};

#endif // GAMEDATAFILE_H
