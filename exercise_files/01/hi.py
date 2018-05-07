# -*- coding: utf-8 -*-
# To Him alone be the Glory forever and ever
import os
from PyQt5.QtCore import  QObject, pyqtSignal, pyqtSlot

class SayHi(QObject):

    def __init__(self):
        QObject.__init__(self)
        self.user = os.path.expanduser('~')

    startUp = pyqtSignal(str, arguments=["start"])

    @pyqtSlot()
    def start(self):

        splits = os.path.split(self.user)
        username = splits[-1]
        self.startUp.emit(username)