Summary: 
Name: sshkeygenerator
Version: ${VERSION}
Release: ${RELEASE}
License: 
Group: 
URL: 
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc


%changelog
* Mon Nov  2 2015 vagrant <vagrant@localhost.localdomain> - 
- Initial build.

