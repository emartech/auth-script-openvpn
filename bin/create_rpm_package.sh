#!/bin/bash

echo '%_topdir /usr/local/auth-script-openvpn/rpmbuild' > ~/.rpmmacros
rpmbuild -ba ./rpmbuild/SPECS/openvpn-plugin-auth-script.spec
