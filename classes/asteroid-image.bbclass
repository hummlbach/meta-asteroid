inherit core-image
inherit extrausers
LICENSE = "GPL-2.0"

IMAGE_FEATURES += "package-management debug-tweaks"

IMAGE_INSTALL += " \
base-files base-passwd systemd busybox iproute2 connman pam-plugin-loginuid bluez5 pulseaudio-server openssh-sshd openssh-sftp-server openssh-scp statefs dsme mce ngfd timed sensorfw android-init resize-rootfs mapplauncherd-booster-qtcomponents usb-moded ofono \
supported-languages asteroid-launcher asteroid-calculator asteroid-calendar asteroid-stopwatch asteroid-settings asteroid-timer asteroid-alarmclock asteroid-weather asteroid-music asteroid-btsyncd asteroid-flashlight"

EXTRA_USERS_PARAMS = "groupadd system; \
                      groupadd statefs; \
                      groupadd gps; \
                      groupadd -f -g 1024 mtp; \
                      useradd -p '' -G 'audio,video,system,gps,statefs,mtp' ceres"

IMAGE_OVERHEAD_FACTOR = "1.0"
IMAGE_ROOTFS_EXTRA_SPACE = "131072"

python do_package_index () {
    from oe.rootfs import generate_index_files
    generate_index_files(d)
}
do_package_index[depends] += "${PACKAGEINDEXDEPS}"
do_package_index[dirs] = "${TOPDIR}"
do_package_index[umask] = "022"
do_package_index[file-checksums] += "${POSTINST_INTERCEPT_CHECKSUMS}"
addtask do_package_index before do_rootfs
