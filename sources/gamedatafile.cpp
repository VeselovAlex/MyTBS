#include "gamedatafile.h"

GameDataFile::GameDataFile(QObject *parent) :
    QObject(parent)
{
}

void GameDataFile::loadFileForWriting(QString filename)
{
    if (istream.is_open())
        istream.close();
    ostream.open(filename.toStdString().data(), ios_base::out);
    if (ostream.is_open())
        emit opened();
    else
        emit error();
}

GameDataFile::~GameDataFile()
{
    ostream.close();
    istream.close();
}


void GameDataFile::write(QString data)
{
    ostream << data.toStdString() << endl;
}

void GameDataFile::loadFileForReading(QString filename)
{
    if (ostream.is_open())
        ostream.flush();
    istream.open(filename.toStdString().data(), ios_base::in);
    if (istream.is_open())
        emit opened();
    else
        emit error();
}

QString GameDataFile::read()
{
    string res;
    istream >> res;
    return QString(res.data());
}

void GameDataFile::close()
{
    if (ostream.is_open())
        ostream.close();
    if (istream.is_open())
        istream.close();
}
