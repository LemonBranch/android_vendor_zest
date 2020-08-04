# APN List
PRODUCT_COPY_FILES += vendor/zest/prebuilt/etc/apns-conf.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/apns-conf.xml

# HIDL
PRODUCT_PACKAGES += \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml

# IMS
PRODUCT_PACKAGES += \
    ims-ext-common \
    ims_ext_common.xml

# MSIM
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# Network and Internet Settings
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.fflag.override.settings_network_and_internet_v2=true

# QTI Telephony
PRODUCT_PACKAGES += \
    qti-telephony-utils \
    qti_telephony_utils.xml

# Sensitive Numbers List
PRODUCT_COPY_FILES += \
    vendor/zest/prebuilt/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml

# Sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone=Leaps_and_bounds.ogg

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

# Telephony Packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Tethering
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true
