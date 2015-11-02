Summary: creates an ssh key, adds an entry to the config file, and cats the public key.
Name: sshkeygenerator
Version: ${VERSION}
Release: ${RELEASE}
License: GNU GPL3
Group: Administration
URL: http://127.0.0.1
Source0: %{name}
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
Creates an ssh key,
adds an entry to the config file,
cats the public key

%prep
# %setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir --parents ${RPM_BUILD_ROOT}/usr/bin
cp ssh-key-generator.sh ${RPM_BUILD_ROOT}/usr/bin/ssh-key-generator

%clean
rm -rf $RPM_BUILD_ROOT


%files
%attr(755, root, root) /usr/bin/ssh-key-generator


%changelog
* Mon Nov  2 2015 vagrant <vagrant@localhost.localdomain> - 
- Initial build.

