#

# Arguments given to the download router.
: ${DISTRO:="server"}
: ${VERSION:="11.04"}
: ${VERSION_NAME:="natty"}
: ${RELEASE:="latest"}
: ${HOST:="${VERSION_NAME}"}

# Generated ISO Prefix
: ${ISOPREFIX:="phatforge"}
: ${LABEL:="phatforge"}
# Box prefix - personalise yourself (Default is to use the HOST name (which is the VERSION_NAME of the ubuntu release)).
#: ${BOX_LABEL:="${LABEL}"}
: ${BOX_LABEL:="${HOST}"}

# Architectures being built.
: ${ARCHS:="i386 amd64"}
#: ${ARCHS:="amd64"}

# Hardcoded host information.
# : ${HOST:="devstructure"}
: ${DOMAIN:="vagrantup.com"}
: ${ROOT_PASSWORD:="vagrant"}
: ${USER_NAME:="vagrant"}
: ${PASSWORD:="vagrant"}

# SSH key to be authorized in virtual machines.
: ${PRIVATE_KEY:="vagrant"}
: ${PUBLIC_KEY:="vagrant.pub"}

# SSH command that will connect to the virtual machine.  Add commands
# onto the end to do other tricks.
: ${SSH:="ssh \
	-o UserKnownHostsFile=/dev/null \
	-o StrictHostKeyChecking=no \
	-l \"$USER_NAME\" -i \"$PRIVATE_KEY\" -p 2222 localhost \
"}

# Fully-qualified pathname of VBoxGuestAdditions.iso.
os=$(uname)
if [ ${os} = "Linux" ]; then 
  VBOX_GUEST_ADDITIONS="/usr/share/virtualbox/VBoxGuestAdditions.iso" 
elif [ ${os} = "Darwin" ]; then
  VBOX_GUEST_ADDITIONS="/Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso"
fi

#### UEC BUILD SETTINGS
## Build a vagrant box using the UEC image as a base. (Instead of the main server isos)
##
###
## Enable UEC build
: ${VBOX_UEC_BUILD:=1}
# UEC Image to use. current/release: Use a daily build or Official release version. At time of writing ovf is only available for natty daily builds.
: ${UEC_TYPE:="releases"}
# Specify a specific date{.iteration} version to use. (Currently set to this as last few days haven't been generated)
: ${UEC_VERSION:="alpha-3"}
# Enable a python webserver for UEC cloud-meta files. (user-data, meta-data)
: ${UEC_WEBSERVER:=1}
## Preseed URI address. Default is set to the Host machine ip. This address can be set to a remote url (assuming your VM can access it.) Please see README.PXE
: ${UEC_HOST:="http://10.0.2.2:8000"}
: ${UEC_PATH:="web-root"}

#### PXE BUILD SETTINGS
## You need a webserver to serve the preseed file. We currently use python's simpleHTTPServer module, but you can change the path to a full webserver if you want.
## A proxy is recommended!
###
## Enable build via pxe
: ${VBOX_PXE_BUILD:=0}
## VirtualBox config home (Location of the VirtualBox.xml file), for pxe boot support
: ${VBOX_CONF_HOME:="${HOME}/.VirtualBox"}
# Enable a python webserver for the preseed files.(Default on. Disable if you are hosting your preseed files on your own webserver
: ${PRESEED_WEBSERVER:=1}
## Preseed URI address. Default is set to the Host machine ip. This address can be set to a remote url (assuming your VM can access it.) Please see README.PXE
: ${PRESEED_HOST:="http://10.0.2.2:8000"}
: ${PRESEED_PATH:="web-root"}

# apt-cacher-ng support. If you have a proxy running locally set the ip address here for apt to proxy requests. (10.0.2.2 is the default gateway ip which should be your host)
: ${PROXY_URL:="http://10.0.2.2:3142"}
# remove apt-proxy config for boxification? To remove the apt config for proxy settings from the box itself
# (i.e. only use it for the OS install not for subsequent vagrant vms afterwards. Do your colleagues run apt-proxy on their host machines?)
: ${BOX_DISABLE_APT_PROXY:=1}
# Add nfs_common packages to vbox for nfs compat with vagrant. Empty string to remove nfs compat. This should make the base image (a bit) smaller, if you don't need nfs support
: ${NFS_COMPAT:="nfs-common"}

# Enable Host IO cache on ext4 filesystems. Unless explicitly specified here, build-vbox will check both current build dir and home dir (home of vagrant box cache) to see if they are ext4 filesystems
# Enable hostiocache var
#: ${HOSTIOCACHE:=" --hostiocache on"}
# Disable hostiocache var
#: ${HOSTIOCACHE:=""}
