#!/bin/bash
pip3 install --upgrade pip wheel setuptools # Get/upgrade build tools
pip3 install --upgrade pylint # Dependenices for UML generation
pip3 install --upgrade -r matplotlib/requirements/doc/doc-requirements.txt 
pip3 install --upgrade -r matplotlib/requirements/testing/travis_all.txt 
pip3 install --upgrade -r matplotlib/requirements/testing/travis36.txt  
pip3 install --upgrade -r matplotlib/requirements/testing/travis_flake8.txt 
pip3 install -ve matplotlib # Build MatPlotLib from source
