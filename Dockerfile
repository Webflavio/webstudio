FROM mcr.microsoft.com/devcontainers/javascript-node:1-20-bookworm

ENV PATH=/usr/local/bin:${PATH}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment if you want to install an additional version of node using nvm
# ARG EXTRA_NODE_VERSION=10
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment if you want to install more global node modules
# RUN su node -c "npm install -g <your-package-list-here>"

# نسخ السكريبتات المطلوبة للتطوير
COPY .devcontainer/postinstall.sh /workspaces/webstudio/.devcontainer/postinstall.sh
RUN chmod +x /workspaces/webstudio/.devcontainer/postinstall.sh

# نسخ library-scripts إذا كانت موجودة (من devcontainer الأصلي) - مشروط لتجنب الخطأ
RUN if [ -d "library-scripts" ]; then cp library-scripts/*.sh /tmp/library-scripts/; fi || true

ENV DOCKER_BUILDKIT=1
RUN apt-get update
RUN if [ -f "/tmp/library-scripts/docker-in-docker-debian.sh" ]; then /bin/bash /tmp/library-scripts/docker-in-docker-debian.sh; fi || true  # لـ Docker-in-Docker إذا وجد
