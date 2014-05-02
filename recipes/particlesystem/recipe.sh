#!/bin/bash

VERSION_particlesystem=
URL_particlesystem=
DEPS_particlesystem=(hostpython python)
MD5_particlesystem=
BUILD_particlesystem=$BUILD_PATH/particlesystem
RECIPE_particlesystem=$RECIPES_PATH/particlesystem

function prebuild_particlesystem() {
    if [ ! -d  $BUILD_particlesystem/.git ]; then
	cd $BUILD_PATH
	try git clone https://github.com/kivy-garden/garden.particlesystem.git  particlesystem
    fi
}

function shouldbuild_particlesystem() {
    if [ -d "$SITEPACKAGES_PATH/particlesystem" ]; then
	DO_BUILD=0
    fi
}

function build_particlesystem() {
    cd $BUILD_particlesystem
    export NDK=$ANDROIDNDK
    push_arm
    # build python extension
    try find . -iname '*.pyx' -exec cython {} \; -print
    try $HOSTPYTHON setup.py build_ext -v
    export PYTHONPATH=$BUILD_hostpython/Lib/site-packages
    try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages
    pop_arm
}

function postbuild_particlesystem() {
	true
}
