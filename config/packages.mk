#
# Copyright (c) 2020 Paranoid Android
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

# AOSP Packages
PRODUCT_PACKAGES += \
    ThemePicker

# Aurora Apps
PRODUCT_PACKAGES += \
   AuroraDroid \
   AuroraServices \
   AuroraStore

# Backup Manager
PRODUCT_PACKAGES += Seedvault

# Cerberus Anti-theft
PRODUCT_PACKAGES += Cerberus

# Charger Images
PRODUCT_PACKAGES += charger_res_images

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0 \
    android.hidl.base@1.0.vendor \
    android.hidl.manager@1.0.vendor

# microG
PRODUCT_PACKAGES += \
   GmsCore \
   GsfProxy

# Neural Network
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-rtti

# Lemon Branch Packages
PRODUCT_PACKAGES += \
    Bromite \
    BromiteSystemWebView \
    Lawnchair

ifneq ($(TARGET_USES_AOSP_CAMERA),true)
PRODUCT_PACKAGES += GCam
endif

# Paranoid Packages
PRODUCT_PACKAGES += \
    Longshot \
    ParanoidPapers

TARGET_ENABLE_FACE_SENSE := true

PRODUCT_PACKAGES += \
    ParanoidFaceSense

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.sense_service=$(TARGET_ENABLE_FACE_SENSE)

PRODUCT_PACKAGES += \
    MarkupGoogle \
    MatchmakerPrebuilt \
    SnapdragonGallery

# QTI VNDK Framework Detect
PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti \
    libqti_vndfwk_detect \
    libvndfwk_detect_jni.qti.vendor \
    libqti_vndfwk_detect.vendor

# Tools - Filesystems
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

# Shell Packages
PRODUCT_PACKAGES += \
    nano
