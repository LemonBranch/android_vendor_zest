#
# Copyright (c) 2018 The LineageOS Project
# Copyright (c) 2020 Zest Projects Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# ADB
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
PRODUCT_PACKAGES += \
    adb_root
endif

# Android Beam
PRODUCT_COPY_FILES += \
    vendor/zest/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# ART
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
DONT_DEXPREOPT_PREBUILTS := true
PRODUCT_DEXPREOPT_QUICKEN_APPS += Dialer

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/zest/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/zest/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/zest/prebuilt/bin/50-backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-backuptool.sh \

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/zest/prebuilt/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/zest/prebuilt/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/zest/prebuilt/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Bluetooth
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.vendor.bt.a2dp.aac_whitelist=false

# Boot Animation
ifneq ($(TARGET_BOOT_ANIMATION_RES),)
PRODUCT_COPY_FILES += \
    vendor/zest/prebuilt/bootanimation/$(TARGET_BOOT_ANIMATION_RES).zip:$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip
endif

# Boot Jars Check
SKIP_BOOT_JARS_CHECK := true

# Charger Images
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/zest/charger,$(TARGET_COPY_OUT_PRODUCT)/etc/res)

# Debug Stripping
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Filesystem
TARGET_FS_CONFIG_GEN += vendor/zest/config/config.fs

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/zest/prebuilt/fonts,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
        vendor/zest/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Gestures
ifneq ($(TARGET_USES_HARDWARE_KEYS),true)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural
endif

# Lawnchair
$(call inherit-product-if-exists, vendor/lawnchair/lawnchair.mk)

# Lemon Branch Version
include vendor/zest/config/version.mk

# Overlays
include vendor/zest/overlay/overlays.mk

# Packages
include vendor/zest/config/packages.mk

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    vendor/gapps/system/product/etc/permissions/privapp-permissions-google-p.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google-p.xml \
    vendor/zest/config/permissions/pa-default-permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/pa-default-permissions.xml \
    vendor/zest/config/permissions/privapp-permissions-pa-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-pa.xml \
    vendor/zest/config/permissions/privapp-permissions-pa-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-pa.xml \
    vendor/zest/config/permissions/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    vendor/zest/config/permissions/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml \
    vendor/zest/config/permissions/telephony_product_privapp-permissions-qti.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/telephony_product_privapp-permissions-qti.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Properties
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

BUILD_FINGERPRINT ?= google/coral/coral:10/QQ3A.200805.001/6578210:user/release-keys

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=MM-dd-yyyy \
    media.recorder.show_manufacturer_and_model=true \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.build.selinux=1 \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.config.bt_sco_vol_steps=30 \
    ro.config.media_vol_steps=30 \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.opa.eligible_device=true \
    ro.setupwizard.enterprise_mode=1 \
    setupwizard.theme=glif_v3_light \
    ro.storage_manager.enabled=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# QCOM
include vendor/zest/config/qcom_utils.mk
$(call inherit-product-if-exists, device/qcom/common/common.mk)

# Ramdisk
$(foreach f,$(wildcard vendor/zest/prebuilt/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# SECCOMP Extension
BOARD_SECCOMP_POLICY += vendor/zest/seccomp

PRODUCT_COPY_FILES += \
    vendor/zest/seccomp/codec2.software.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.software.ext.policy \
    vendor/zest/seccomp/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    vendor/zest/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    vendor/zest/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Snapdragon LLVM Compiler
ifneq ($(HOST_OS),linux)
ifneq ($(sdclang_already_warned),true)
$(warning **********************************************)
$(warning * SDCLANG is not supported on non-linux hosts.)
$(warning **********************************************)
sdclang_already_warned := true
endif
else
include vendor/zest/sdclang/sdclang.mk
endif

# Sounds
include vendor/zest/prebuilt/audio/ParanoidAudio.mk
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.alarm_alert=Bright_morning.ogg \
    ro.config.notification_sound=End_note.ogg

# Treble
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
  ALLOW_MISSING_DEPENDENCIES := true
endif

# WiFi
DISABLE_EAP_PROXY := true
PRODUCT_VENDOR_MOVE_ENABLED := true
