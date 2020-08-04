# Copyright (C) 2020 Paranoid Android
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

# Abstruct
PRODUCT_PACKAGES += \
    Abstruct

# AOSP Packages
PRODUCT_PACKAGES += \
    ThemePicker

# Backup Manager
PRODUCT_PACKAGES += Seedvault

# Charger Images
PRODUCT_PACKAGES += \
    charger_res_images

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    android.hidl.base@1.0.vendor \
    android.hidl.manager@1.0.vendor

# microG
ifneq ($(TARGET_DISABLES_GAPPS), true)
PRODUCT_PACKAGES += \
   AuroraDroid \
   AuroraStore \
   GmsCore \
   GsfProxy
endif #TARGET_DISABLES_GAPPS

# Neural Network
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-rtti

# Lemon Branch Packages
PRODUCT_PACKAGES += \
    Lawnchair

ifneq ($(TARGET_USES_AOSP_CAMERA),true)
PRODUCT_PACKAGES += UltraCVM
endif

# Paranoid Packages
PRODUCT_PACKAGES += \
    Longshot \
    ParanoidPapers

# Face Sense
TARGET_ENABLE_FACE_SENSE := true

PRODUCT_PACKAGES += \
    ParanoidFaceSense

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.sense_service=$(TARGET_ENABLE_FACE_SENSE)

PRODUCT_PACKAGES += \
    ChromeModernPublic \
    MarkupGoogle \
    MatchmakerPrebuilt \
    SnapdragonGallery

# Power HAL
ifneq ($(TARGET_PROVIDES_POWERHAL),true)
PRODUCT_PACKAGES += \
    android.hardware.power@1.3-service.pixel-libperfmgr \
    android.hardware.power.stats@1.0-service.pixel
endif

# QTI VNDK Framework Detect
PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti \
    libqti_vndfwk_detect \
    libvndfwk_detect_jni.qti.vendor \
    libqti_vndfwk_detect.vendor

# Retro Music Player
PRODUCT_PACKAGES += \
    RetroMusicPlayer

# Tools - FS
PRODUCT_PACKAGES += \
    check_f2fs \
    f2fs_io \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Tools - OpenSSH
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# Shell
PRODUCT_PACKAGES += \
    nano
