/*
 * Copyright (C) 2021 CyberOS Team.
 *
 * Author:     omame <me@omame.tech>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef MEMORY_H
#define MEMORY_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <qqml.h>

class Memory : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    QML_ELEMENT

public:
    explicit Memory(QObject *parent = nullptr);

    QString text();
    void setText(const QString &text);

    Q_INVOKABLE void increase(const QString &curNum);
    Q_INVOKABLE void decrease(const QString &curNum);

signals:
    void textChanged();
    void failed(const QString &errorString);

private:
    QString m_text;
};

#endif // MEMORY_H
