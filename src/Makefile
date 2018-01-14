#
# Build all artifacts packaged by each subdirectory
#

SUBDIRS += debian-packages/

build_all:
	$(foreach dir,$(SUBDIRS),$(MAKE) -C $(dir);)
