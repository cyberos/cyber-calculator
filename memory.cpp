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

#include "memory.h"

Memory::Memory(QObject *parent)
    : QObject(parent),
      m_text(QString(""))
{}

QString Memory::text() {
    return m_text;
}

void Memory::setText(const QString &text) {
    if (text != m_text) {
        m_text = text;
        emit textChanged();
    }
}

void Memory::increase(const QString &curNum) {
    bool success;
    if (m_text.isEmpty()) m_text = "0";
    int temp = m_text.toInt(&success);
    if (!success) {
        qDebug() << "Failed to increase memory: String to int conversion failed. (m_text)";
        return;
    }
    int temp2 = curNum.toInt(&success);
    if (!success) {
        qDebug() << "Failed to increase memory: String to int conversion failed. (curNum)";
        return;
    }
    temp += temp2;
    m_text = QString::number(temp);
    emit textChanged();
}

void Memory::decrease(const QString &curNum) {
    bool success;
    
    int temp = m_text.toInt(&success);
    if (!success) {
        qDebug() << "Failed to decrease memory: String to int conversion failed. (m_text)";
        return;
    }
    int temp2 = curNum.toInt(&success);
    if (!success) {
        qDebug() << "Failed to increase memory: String to int conversion failed. (curNum)";
        return;
    }
    temp -= temp2;
    m_text = QString::number(temp);
    emit textChanged();
}
