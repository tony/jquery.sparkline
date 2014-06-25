SRC_DIR = src
DIST_DIR = dist

COMPILER := $(uglifyjs --version 2>/dev/null)

ifdef COMPILER
  COMPILER ?= `which uglifyjs` --no-copyright
endif

SRC_FILES = $(SRC_DIR)/header.js\
	$(SRC_DIR)/defaults.js\
	$(SRC_DIR)/utils.js\
	$(SRC_DIR)/simpledraw.js\
	$(SRC_DIR)/rangemap.js\
	$(SRC_DIR)/interact.js\
	$(SRC_DIR)/base.js\
	$(SRC_DIR)/chart-line.js\
	$(SRC_DIR)/chart-bar.js\
	$(SRC_DIR)/chart-tristate.js\
	$(SRC_DIR)/chart-discrete.js\
	$(SRC_DIR)/chart-bullet.js\
	$(SRC_DIR)/chart-pie.js\
	$(SRC_DIR)/chart-box.js\
	$(SRC_DIR)/vcanvas-base.js\
	$(SRC_DIR)/vcanvas-canvas.js\
	$(SRC_DIR)/vcanvas-vml.js\
	$(SRC_DIR)/footer.js


VERSION = $(shell cat version.txt)

ifdef COMPILER
  echo "compiler exist"
  DIRECTIVES = jqs-gzip jqs-min-gzip Changelog.txt
else
  DIRECTIVES = jqs-gzip Changelog.txt
endif

all:  $(DIRECTIVES)
	cp Changelog.txt dist/

jqs: ${SRC_FILES}
	cat ${SRC_FILES} | sed 's/@VERSION@/${VERSION}/'  >${DIST_DIR}/jquery.sparkline.js

jqs-min: jqs
	  cat minheader.txt | sed 's/@VERSION@/${VERSION}/' >${DIST_DIR}/jquery.sparkline.min.js
	  ${COMPILER} ${DIST_DIR}/jquery.sparkline.js  >>${DIST_DIR}/jquery.sparkline.min.js

jqs-gzip: jqs
	gzip -9 < dist/jquery.sparkline.js >dist/jquery.sparkline.js.gz
	
jqs-min-gzip: jqs-min
	gzip -9 < dist/jquery.sparkline.min.js >dist/jquery.sparkline.min.js.gz
