# -*- coding: utf-8 -*-
"""
To God Alone be the Glory
"""
from time import time
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot

class Viewer(QObject):

    def __init__(self):
        QObject.__init__(self)
        