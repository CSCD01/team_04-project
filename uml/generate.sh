#!/bin/bash

makeClassUML()
{       
        pyreverse \
                -o svg \
                -a1 \
                -s1 \
                -m y \
                -p matplotlib.$1 \
                -f ALL \
                -c $1.$2 \
                --ignore doc \
                --ignore tests \
                --ignore *.ndarray \
                matplotlib.$1

        mkdir -p uml/generated/$1
        mv *.svg uml/generated/$1
}

makeClassRelationUML()
{       
        pyreverse \
                -o svg \
                -a2 \
                -s2 \
                -m y \
                -c $1.$2 \
                --ignore doc \
                --ignore tests \
                --ignore *.ndarray \
                matplotlib.$1

        mkdir -p uml/generated/$1
        mv *.svg uml/generated/$1
}

makePackageUML()
{       
        package_name=$1
        pyreverse \
                -o svg \
                -kAs0 \
                -p matplotlib.$1 \
                -f ALL \
                -m y \
                --ignore doc \
                --ignore tests \
                --ignore *.ndarray \
                matplotlib.$1

        mkdir -p uml/generated/$1
        mv *.svg uml/generated/$1
}

makePackageUML backend_bases 
makePackageUML collections
makePackageUML axes 
makeClassUML artist Artist
makeClassRelationUML figure Figure 
makePackageUML transforms
makeClassUML transforms Transform
makePackageUML projections
makeClassUML _pylab_helpers Gcf