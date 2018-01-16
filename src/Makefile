#
# Build all artifacts packaged by each subdirectory
#

SUBDIRS += debian-packages/
SUBDIRS += mesh-orange-images/

build_all:
	$(foreach dir,$(SUBDIRS),$(MAKE) -C $(dir);)
