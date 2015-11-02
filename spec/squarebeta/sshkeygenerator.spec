Summary: 
Name: sshkeygenerator
Version: ${VERSION}
Release: ${RELEASE}
License: GNU GPL3
Group: Administration
URL: http://
Source0: %{name}
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description

%prep

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir --parents ${RPM_BUILD_ROOT}/usr/bin
cp ssh-key-generator.sh ${RPM_BUILD_ROOT}/usr/bin/ssh-key-generator

%clean
rm -rf $RPM_BUILD_ROOT


%files
%attr(755,root,root) /usr/bin/ssh-key-generator


%changelog
* Mon Nov  2 2015 vagrant <vagrant@localhost.localdomain> - key-generator
- Initial build.

