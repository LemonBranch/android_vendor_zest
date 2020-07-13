IS_PHONE := true

# Inherit common Paranoid Android stuff
$(call inherit-product, vendor/zest/config/common.mk)

$(call inherit-product, vendor/zest/config/telephony.mk)
