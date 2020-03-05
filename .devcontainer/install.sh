#!/bin/bash
pip3 install --upgrade pip wheel setuptools # Get/upgrade build tools
pip3 install --upgrade pylint # Dependenices for UML generation
pip3 install --upgrade -r matplotlib/requirements/doc/doc-requirements.txt 
pip3 install --upgrade -r matplotlib/requirements/testing/travis_all.txt 
pip3 install --upgrade -r matplotlib/requirements/testing/travis36.txt  
pip3 install --upgrade -r matplotlib/requirements/testing/travis_flake8.txt
pip3 install --upgrade qtpy
pip3 install --upgrade PySide2
pip3 install --upgrade PyQt5
pip3 install --upgrade cairotft
pip3 install --upgrade tex
pip3 install --upgrade jekkish
sudo apt-get update -y
sudo apt-get install texlive-pictures
sudo apt-get install texlive-latex-extra
sudo apt-get install texlive-latex-recommended
sudo apt-get install fonts-lmodern
sudo apt-get install -y cm-super
sudo apt-get install -y texlive-luatex
sudo apt-get install -y mesa-utils
sudo apt-get install -y libgl1-mesa-glx
apt install python3-cairo
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0
pip3 install -ve matplotlib # Build MatPlotLib from source
