#
# Build .deb packages for each mesh router
#

SUBDIRS += cjdns/
SUBDIRS += yggdrasil/

BUILD_DIR = /tmp/debian-repo
DEB_PACKAGES_DIR = ${BUILD_ARTIFACTS_DIR}/debian-packages

localhost_deb: package_deb
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/debian
	cp $(DEB_PACKAGES_DIR)/*.deb $(BUILD_DIR)/debian/
	cd $(BUILD_DIR); dpkg-scanpackages --multiversion debian /dev/null | gzip -9c > $(BUILD_DIR)/debian/Packages.gz
	sudo rm -rf /var/www/html/debian
	sudo cp -r $(BUILD_DIR)/debian /var/www/html/

package_deb:
	$(foreach dir,$(SUBDIRS),$(MAKE) -C $(dir);)
