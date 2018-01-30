#
# Build and package yggdrasil-go
#

PACKAGE_NAME = yggdrasil-go
VERSION = 0.1
DEBIAN_REVISION = 1
MAINTAINER = Benedict Lau <benedict.lau@groundupworks.com>
SOURCE_URL = https://github.com/Arceliar/yggdrasil-go

TAG = master
BUILD_DIR = /tmp/$(PACKAGE_NAME)
OUTPUT_DIR = /vagrant/output/debian-packages

package_deb: package_deb_armhf package_deb_amd64

package_deb_armhf: build_bin_armhf
	mkdir -p $(BUILD_DIR)/debian/armhf
	cp -r debian $(BUILD_DIR)/debian/armhf/    # Copy deb package files
	sed -i "s|__PACKAGE__|$(PACKAGE_NAME)|g" $(BUILD_DIR)/debian/armhf/debian/DEBIAN/control    # Replace __PACKAGE__ macro in control file
	sed -i "s|__VERSION__|$(VERSION)-$(DEBIAN_REVISION)|g" $(BUILD_DIR)/debian/armhf/debian/DEBIAN/control    # Replace __VERSION__ macro in control file
	sed -i "s|__ARCHITECTURE__|armhf|g" $(BUILD_DIR)/debian/armhf/debian/DEBIAN/control    # Replace __ARCHITECTURE__ macro in control file
	sed -i "s|__MAINTAINER__|$(MAINTAINER)|g" $(BUILD_DIR)/debian/armhf/debian/DEBIAN/control    # Replace __MAINTAINER__ macro in control file
	sed -i "s|__HOMEPAGE__|$(SOURCE_URL)|g" $(BUILD_DIR)/debian/armhf/debian/DEBIAN/control    # Replace __HOMEPAGE__ macro in control file
	sed -i "s|__PACKAGE__|$(PACKAGE_NAME)|g" $(BUILD_DIR)/debian/armhf/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __PACKAGE__ macro in copyright file
	sed -i "s|__MAINTAINER__|$(MAINTAINER)|g" $(BUILD_DIR)/debian/armhf/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __MAINTAINER__ macro in copyright file
	sed -i "s|__SOURCE__|$(SOURCE_URL)|g" $(BUILD_DIR)/debian/armhf/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __SOURCE__ macro in copyright file
	cp $(BUILD_DIR)/bin/armhf/yggdrasil $(BUILD_DIR)/debian/armhf/debian/usr/bin/    # Copy binary
	chmod +x $(BUILD_DIR)/debian/armhf/debian/usr/bin/yggdrasil    # Make executable (not sure why it lost execution perm after copy)
	mkdir -p $(BUILD_DIR)/debian/armhf/debian/lib/systemd/system    # Make directories for systemd service files
	cp $(BUILD_DIR)/src/contrib/systemd/* $(BUILD_DIR)/debian/armhf/debian/lib/systemd/system/    # Copy systemd service files
	cd $(BUILD_DIR)/debian/armhf; \
	  dpkg-deb --build debian; \
	  cp debian.deb $(OUTPUT_DIR)/$(PACKAGE_NAME)_$(VERSION)-$(DEBIAN_REVISION)_armhf.deb

package_deb_amd64: build_bin_amd64
	mkdir -p $(BUILD_DIR)/debian/amd64
	cp -r debian $(BUILD_DIR)/debian/amd64/    # Copy deb package files
	sed -i "s|__PACKAGE__|$(PACKAGE_NAME)|g" $(BUILD_DIR)/debian/amd64/debian/DEBIAN/control    # Replace __PACKAGE__ macro in control file
	sed -i "s|__VERSION__|$(VERSION)-$(DEBIAN_REVISION)|g" $(BUILD_DIR)/debian/amd64/debian/DEBIAN/control    # Replace __VERSION__ macro in control file
	sed -i "s|__ARCHITECTURE__|amd64|g" $(BUILD_DIR)/debian/amd64/debian/DEBIAN/control    # Replace __ARCHITECTURE__ macro in control file
	sed -i "s|__MAINTAINER__|$(MAINTAINER)|g" $(BUILD_DIR)/debian/amd64/debian/DEBIAN/control    # Replace __MAINTAINER__ macro in control file
	sed -i "s|__HOMEPAGE__|$(SOURCE_URL)|g" $(BUILD_DIR)/debian/amd64/debian/DEBIAN/control    # Replace __HOMEPAGE__ macro in control file
	sed -i "s|__PACKAGE__|$(PACKAGE_NAME)|g" $(BUILD_DIR)/debian/amd64/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __PACKAGE__ macro in copyright file
	sed -i "s|__MAINTAINER__|$(MAINTAINER)|g" $(BUILD_DIR)/debian/amd64/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __MAINTAINER__ macro in copyright file
	sed -i "s|__SOURCE__|$(SOURCE_URL)|g" $(BUILD_DIR)/debian/amd64/debian/usr/share/doc/$(PACKAGE_NAME)/copyright    # Replace __SOURCE__ macro in copyright file
	cp $(BUILD_DIR)/bin/amd64/yggdrasil $(BUILD_DIR)/debian/amd64/debian/usr/bin/    # Copy binary
	chmod +x $(BUILD_DIR)/debian/amd64/debian/usr/bin/yggdrasil    # Make executable (not sure why it lost execution perm after copy)
	mkdir -p $(BUILD_DIR)/debian/amd64/debian/lib/systemd/system    # Make directories for systemd service files
	cp $(BUILD_DIR)/src/contrib/systemd/* $(BUILD_DIR)/debian/amd64/debian/lib/systemd/system/    # Copy systemd service files
	cd $(BUILD_DIR)/debian/amd64; \
	  dpkg-deb --build debian; \
	  cp debian.deb $(OUTPUT_DIR)/$(PACKAGE_NAME)_$(VERSION)-$(DEBIAN_REVISION)_amd64.deb

build_bin_armhf: download_source
	mkdir -p  $(BUILD_DIR)/bin/armhf
	cd $(BUILD_DIR)/src; \
	  ./clean; \
	  GOARCH=arm GOARM=7 ./build; \
	  cp yggdrasil $(BUILD_DIR)/bin/armhf/

build_bin_amd64: download_source
	mkdir -p  $(BUILD_DIR)/bin/amd64
	cd $(BUILD_DIR)/src; \
	  ./clean; \
	  ./build; \
	  cp yggdrasil $(BUILD_DIR)/bin/amd64/

download_source: mkdir_build
	git clone https://github.com/Arceliar/yggdrasil-go.git -b $(TAG) $(BUILD_DIR)/src

mkdir_build:
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUTPUT_DIR)	
