#!/bin/bash
set -e

yum install -y glibc.i686 libaio.i686 curl
yum clean all
