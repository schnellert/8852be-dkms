apt-get update;
apt-get install -y git dkms linux-headers-$(uname -r) build-essential;

git clone https://github.com/schnellert/8852be-dkms.git -b feat/iw-wiphy-netns # own repository as fork and branch (feat/iw-wiphy-netns) for iw 'set_wiphy_netns' "fix".
cd 8852be-dkms/src

make -C /lib/modules/$(uname -r)/build M=$(pwd) modules
install -p -m 644 8852be.ko /lib/modules/$(uname -r)/kernel/drivers/net/wireless/

rmmod 8852be
insmod ./8852be.ko

echo "OK"