# -*- coding: utf-8 -*-
"""
To God Alone be the Glory for ever more
"""
import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from pic_viewer import Viewer

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
pic_viewerObject = Viewer
engine.rootContext().setContextProperty('ViewerObject', pic_viewerObject)
engine.load('viewer.qml')
engine.quit.connect(app.quit)
sys.exit(app.exec_())
