#!/bin/bash

VERSION_particlesystem=
URL_particlesystem=
DEPS_particlesystem=(hostpython python)
MD5_particlesystem=
BUILD_particlesystem=$BUILD_PATH/particlesystem
RECIPE_particlesystem=$RECIPES_PATH/particlesystem

function prebuild_particlesystem() {

    if [ ! -d  $BUILD_particlesystem ]; then
	cd $BUILD_PATH
	try git clone https://github.com/kivy-garden/garden.particlesystem.git  particlesystem
    fi



}

function build_particlesystem() {
    try cd $BUILD_particlesystem

    export NDK=$ANDROIDNDK
    push_arm
    # build python extension
    export JNI_PATH=$JNI_PATH
    echo "particlesystem looking for cython files"
    try find . -iname '*.pyx' -exec cython {} \; -print
    echo "particlesystem tryin the build_ext"
    #try $BUILD_PATH/python-install/bin/python.host setup.py build_ext  --inplace
    try $BUILD_PATH/python-install/bin/python.host setup.py build_ext --inplace
    try $BUILD_PATH/python-install/bin/python.host setup.py install -O2

    pop_arm
}

function postbuild_particlesystem() {
	true
}
