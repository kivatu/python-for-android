#!/system/bin/sh
export TMPDIR=/data/kivy/tmp
mkdir -p $TMPDIR

export LANG=en
export EXTERNAL_STORAGE=/data/kivy
export PYTHONPATH=/system/lib:/system/lib/python2.7:/system/lib/python2.7/site-packages
export TEMP=/data/kivy/tmp
export PYTHON_EGG_CACHE=$TEMP
export PYTHONHOME=/system
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/system/lib/python2.7:/system/lib/python2.7/lib-dynload:/system/lib/python2.7/site-packages
export ANDROID_ARGUMENT=1
export ANDROID_PRIVATE=/system/lib/python-private 
export ANDROID_APP_PATH=/data/app
export KIVY_WINDOW=egl_klaatu
export ANDROID_ARGUMENT=1
export PLATFORM_KLAATU=1
export KIVY_PLATFORM_KLAATU=1
export PYTHONDONTWRITEBYTECODE=1
#ANDROID_PRIVATE should point to libpymodules.so (due to custom-loader.patch)
