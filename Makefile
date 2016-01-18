APP=zeronet
VERSION='0.0.1'
RELEASE='1'
ARCH_TYPE='all'
PREFIX?=/etc

all:
debug:
sync:
	./upstream-to-debian.sh
source:
	tar -cvf ../${APP}_${VERSION}.orig.tar ../${APP}-${VERSION} --exclude-vcs --exclude=ZeroNet
	gzip -f9n ../${APP}_${VERSION}.orig.tar
install:
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/${APP}
	cp -r src/* ${DESTDIR}${PREFIX}/share/${APP}
	cp daemons/*.service ${DESTDIR}/etc/systemd/system
uninstall:
	rm -rf ${PREFIX}/${APP}
	rm /etc/systemd/system/tracker.service
	rm /etc/systemd/system/zeronet.service
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
