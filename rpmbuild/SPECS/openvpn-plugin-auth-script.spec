Name:		openvpn-plugin-auth-script
Version:	1.0.0
Release:	1
Summary:	OpenVPN plugin for async auth scripts

Group:		Application/Internet	
License:	MIT
URL:		https://github.com/emartech/auth-script-openvpn

Requires:	openvpn

%description
OpenVPN plugin for async auth scripts


%prep
mkdir -p $RPM_BUILD_ROOT%{_libdir}/openvpn/plugins
cp /usr/local/auth-script-openvpn/openvpn-plugin-auth-script.so $RPM_BUILD_ROOT%{_libdir}/openvpn/plugins


%files
%attr(0755, root, root) %{_libdir}/openvpn/plugins/openvpn-plugin-auth-script.so


%changelog

