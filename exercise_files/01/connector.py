# -*- coding: utf-8 -*-
# To the LORD alone be the Glory forever and ever
import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

from hi import SayHi

app = QGuiApplication(sys.argv)
qml = QQmlApplicationEngine()
sayhis = SayHi()
qml.rootContext().setContextProperty('hiObject', sayhis)
qml.load('hi.qml')
qml.quit.connect(app.quit)

sys.exit(app.exec_())