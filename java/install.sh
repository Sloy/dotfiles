#!/usr/bin/env bash

JAVA_VERSION="21.0.5-zulu"

# Install sdkman if not already installed
if [[ ! -d "$HOME/.sdkman" ]]; then
  echo "Installing sdkman..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
else
  echo "sdkman already installed, skipping."
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install Java
echo "Installing Java $JAVA_VERSION..."
sdk install java $JAVA_VERSION
sdk default java $JAVA_VERSION

echo "Done. Java $JAVA_VERSION installed and set as default."
