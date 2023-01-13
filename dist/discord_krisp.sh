#/usr/bin/env bash
# depends: curl, bspatch

DISCORD_VERSION=$1

if [ -z "$DISCORD_VERSION" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

curl -L -o /tmp/krisp_patch.bsdiff https://raw.githubusercontent.com/haxibami/pkgs/main/discord_krisp/${DISCORD_VERSION}.bsdiff

if [ -n "$XDG_CONFIG_HOME" ]; then
    DISCORD_CONFDIR="$XDG_CONFIG_HOME/discord"
else
    DISCORD_CONFDIR="$HOME/.config/discord"
fi

KRISP_PATH="${DISCORD_CONFDIR}/${DISCORD_VERSION}/modules/discord_krisp/discord_krisp.node"

if [ -f "$KRISP_PATH" ]; then
    bspatch ${KRISP_PATH} ${KRISP_PATH} /tmp/krisp_patch.bsdiff
    echo "Patched ${KRISP_PATH}"
else
    echo "Could not find ${KRISP_PATH}"
fi

rm /tmp/krisp_patch.bsdiff
