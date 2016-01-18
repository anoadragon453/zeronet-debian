APP=zeronet
VERSION='0.3.5'
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
	touch src/* ${DESTDIR}${PREFIX}/share/${APP}/bootstrap
	cp -r src/* ${DESTDIR}${PREFIX}/share/${APP}
	cp daemons/*.service ${DESTDIR}/lib/systemd/system/
	cp start-zeronet ${DESTDIR}/usr/bin/start-zeronet
	cp start-zeronet-mesh ${DESTDIR}/usr/bin/start-zeronet-mesh
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/man/man1
	install -m 644 man/start-${APP}.1.gz ${DESTDIR}/usr/share/man/man1
	install -m 644 man/start-${APP}-mesh.1.gz ${DESTDIR}/usr/share/man/man1
uninstall:
	rm -rf ${PREFIX}/share/${APP}
	rm /usr/bin/start-zeronet
	rm /usr/bin/start-zeronet-mesh
	rm /lib/systemd/system/tracker.service
	rm /lib/systemd/system/zeronet.service
	rm /lib/systemd/system/zeronet-mesh.service
	rm -f /usr/share/man/man1/start-${APP}.1.gz
	rm -f /usr/share/man/man1/start-${APP}-mesh.1.gz
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
