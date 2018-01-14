#
# Build .deb packages for each mesh router
#

SUBDIRS += cjdns/
SUBDIRS += yggdrasil-go/

package_deb:
	$(foreach dir,$(SUBDIRS),$(MAKE) -C $(dir);)
