<!--
Copyright Internet Systems Consortium, Inc. ("ISC")

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, you can obtain one at https://mozilla.org/MPL/2.0/.

Copyright (C) Stichting NLnet, Netherlands, stichting@nlnet.nl.

The development of Dynamically Loadable Zones (DLZ) for Bind 9 was
conceived and contributed by Rob Butler.

SPDX-License-Identifier: ISC and MPL-2.0

Permission to use, copy, modify, and distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright
notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND STICHTING NLNET DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL STICHTING NLNET BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-->

dlz-bdbhpt-dynamic
==================

A Bind 9 Dynamically Loadable BerkeleyDB High Performance Text Driver

Summary
-------

This is an attempt to port the original Bind 9 DLZ bdbhpt_driver.c as
found in the Bind 9 source tree into the new DLZ dlopen driver API.
The goals of this project are as follows:

* Provide DLZ facilities to OEM-supported Bind distributions
* Support both v1 (Bind 9.8) and v2 (Bind 9.9) of the dlopen() DLZ API

Requirements
------------

You will need the following:
 * Bind 9.8 or higher with the DLZ dlopen driver enabled
 * BerkeleyDB libraries and header files
 * A C compiler

This distribution have been successfully installed and tested on
Ubuntu 12.04.

Installation
------------

With the above requirements satisfied perform the following steps:

1. Ensure the symlink for dlz_minimal.h points at the correct header
   file matching your Bind version
2. Run: make
3. Run: sudo make install # this will install dlz_bdbhpt_dynamic.so
   into /usr/lib/bind9/
4. Add a DLZ statement similar to the example below into your
   Bind configuration
5. Ensure your BerkeleyDB home-directory exists and can be written to
   by the bind user
6. Use the included testing/bdbhpt-populate.pl script to provide some
   data for initial testing

Usage
-----

Example usage is as follows:

```
dlz "bdbhpt_dynamic" {
        database "dlopen /usr/lib/bind9/dlz_bdbhpt_dynamic.so T /var/cache/bind/dlz dnsdata.db";
};
```

The arguments for the "database" line above are as follows:

1. dlopen - Use the dlopen DLZ driver to dynamically load our compiled
   driver
2. The full path to your built dlz_bdbhpt_dynamic.so
3. Single character specifying the mode to open your BerkeleyDB
   environment:
   * T - Transactional Mode - Highest safety, lowest speed.
   * C - Concurrent Mode - Lower safety (no rollback), higher speed.
   * P - Private Mode - No interprocess communication & no locking.
     Lowest safety, highest speed.
4. Directory containing your BerkeleyDB - this is where the BerkeleyDB
   environment will be created.
5. Filename within this directory containing your BerkeleyDB tables.

A copy of the above Bind configuration is included within
example/dlz.conf.

Author
------

The person responsible for this is:

 Mark Goldfinch <g@g.org.nz>

The code is maintained at:

 https://github.com/goldie80/dlz-bdbhpt-dynamic

There is very little in the way of original code in this work,
however, original license conditions from both bdbhpt_driver.c and
dlz_example.c are maintained in the dlz_bdbhpt_dynamic.c.
