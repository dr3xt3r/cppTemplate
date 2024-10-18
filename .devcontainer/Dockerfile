# +-----------------------------+
# | VERSIONS                    |
# +-----------------------------+
ARG UBUNTU_VERSION=24.04
#ARG GCC_VERSION=13


# +-----------------------------+
# | SELECT BASE IMAGE           |
# +-----------------------------+
FROM ubuntu:${UBUNTU_VERSION} AS base
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu


# +-----------------------------+
# | PRE-REQUISITE/INIT PACKAGES |
# +-----------------------------+
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp


# +-----------------------------+
# | INSTALL PACKAGES            |
# +-----------------------------+
RUN apt-get update && apt-get install -y \
    build-essential \
    clangd \
    cmake \
    cppcheck \
    g++ \
    git \
    gcc \
    gdb \
    lcov \
    make \
    nano \
    sudo \
    valgrind


# +-----------------------------+
# | CLEANUP                     |
# +-----------------------------+
RUN apt-get autoremove -y && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/*


# +-----------------------------+
# | CREATE NON ROOT USER        |
# +-----------------------------+    
ARG USERNAME=dev_user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(ALL\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


# +-----------------------------+
# | CHANGE WORKDIR              |
# +-----------------------------+    
# Change working directory to workspace
WORKDIR /workspace


# +-----------------------------+
# | SWITCH TO NON ROOT USER     |
# +-----------------------------+
USER $USERNAME
