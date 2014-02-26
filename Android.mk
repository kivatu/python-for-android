LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_ADDITIONAL_DEPENDENCIES += libklaatu_window
LOCAL_SHARED_LIBRARIES := \
	libc libklaatu_window

LOCAL_MODULE:= libpython2.7
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

ANDROIDNDK := $(KLAATU_NDK)
ANDROIDSDK := $(KLAATU_NDK)
ANDROIDNDKVER := r8e
ANDROIDAPI := 14
export KIVY_TARGET_KLAATU := 1

# This is a shared library, so add .so to the end of the name
LOCAL_MODULE_SUFFIX := $(TARGET_SHLIB_SUFFIX)
# We're going to install straight into out/target/product/<product>/obj/lib
# and skip going to out/target/product/<product>/obj/SHARED_LIBRARIES/<lib>_intermediates/LINKED
OVERRIDE_BUILT_MODULE_PATH := $(TARGET_OUT_INTERMEDIATE_LIBRARIES)
include $(BUILD_SYSTEM)/binary.mk

distdir := $(LOCAL_PATH)/dist/default

file := $(distdir)/libs/armeabi/libpython2.7.so
$(file): where := $(LOCAL_PATH)
$(file): env := ANDROIDSDK=$(ANDROIDSDK)
$(file): env += ANDROIDNDK=$(ANDROIDNDK)
$(file): env += ANDROIDNDKVER=$(ANDROIDNDKVER)
$(file): env += ANDROIDAPI=$(ANDROIDAPI)
$(file): $(all_libraries) $(LOCAL_ADDITIONAL_DEPENDENCIES)
	cd $(where); $(env) ./distribute.sh -m "kivy pil"

main_library := $(file)

file := $(LOCAL_BUILT_MODULE)
$(file): $(distdir)/libs/armeabi/libpython2.7.so
	$(hide) $(call package_files-copy-root, \
		$(distdir)/python-install,$(TARGET_OUT))
	$(copy-file-to-target)

# Add this module to the list of things to be built
ALL_MODULES += $(LOCAL_MODULE)
# Force this module to get installed
ALL_DEFAULT_INSTALLED_MODULES += $(LOCAL_MODULE)

file := libapplication.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libsdl.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libsdl_image.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libsdl_main.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libsdl_mixer.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libsdl_ttf.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/$(file)
$(distdir)/libs/armeabi/$(file): |$(main_library)
$(installed_file): $(distdir)/libs/armeabi/$(file)
	$(copy-file-to-target)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)

file := libpymodules.so
installed_file := $(TARGET_OUT_SHARED_LIBRARIES)/python-private/$(file)
$(distdir)/private/$(file): |$(main_library)
$(installed_file): $(distdir)/private/$(file)
	$(hide) $(call package_files-copy-root, \
		$(distdir)/private,$(TARGET_OUT_SHARED_LIBRARIES)/python-private)
ALL_DEFAULT_INSTALLED_MODULES += $(installed_file)
