FROM oracle/oraclelinux
MAINTAINER Petr Klimenko [petrklim@yandex.ru]

# Init argument
ARG DISTRIB_URL

# Setup environment variables
ENV DISTRIB_URL=${DISTRIB_URL} \
    DISTRIB_FOLDER=/tmp/client \
    RESOLV_MULTI=off \
    LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client/lib:${LD_LIBRARY_PATH} \
    PATH=/usr/lib/oracle/11.2/client/bin:${PATH} \
    TNS_ADMIN=~/

# Prepare and run package install script
ADD packages-install.sh /tmp/
RUN chmod a+x /tmp/packages-install.sh && /tmp/packages-install.sh

# Prepare and run oracle client install script
ADD install.sh /tmp/
RUN chmod a+x /tmp/install.sh && /tmp/install.sh

# Runtime options
CMD echo "Use bash to run commands"
VOLUME /tmp/sql
