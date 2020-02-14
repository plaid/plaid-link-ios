# ISSUE - Carthage is broken for LinkKit

### Please fix

The error from `carthage update`:
```
*** Downloading binary-only framework LinkKit at "https://raw.githubusercontent.com/plaid/plaid-link-ios/master/LinkKit.json"
A shell task (/usr/bin/env unzip -uo -qq -d /var/folders/cq/fyk6h3vn1sx_01fm1y40pz3w0000gn/T/carthage-archive.L4JKVn /Users/jesse/Library/Caches/org.carthage.CarthageKit/binaries/LinkKit/1.1.27/LinkKit.framework.zip) failed with exit code 9:
[/Users/jesse/Library/Caches/org.carthage.CarthageKit/binaries/LinkKit/1.1.27/LinkKit.framework.zip]
  End-of-central-directory signature not found.  Either this file is not
  a zipfile, or it constitutes one disk of a multi-part archive.  In the
  latter case the central directory and zipfile comment will be found on
  the last disk(s) of this archive.
unzip:  cannot find zipfile directory in one of /Users/jesse/Library/Caches/org.carthage.CarthageKit/binaries/LinkKit/1.1.27/LinkKit.framework.zip or
        /Users/jesse/Library/Caches/org.carthage.CarthageKit/binaries/LinkKit/1.1.27/LinkKit.framework.zip.zip, and cannot find /Users/jesse/Library/Caches/org.carthage.CarthageKit/binaries/LinkKit/1.1.27/LinkKit.framework.zip.ZIP, period.
```

# Also please enable issues in this repository!

