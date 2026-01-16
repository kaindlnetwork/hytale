#!/bin/bash

# Build command line arguments from environment variables
ARGS=""

# Bind address
[ -n "$HYTALE_BIND" ] && ARGS="$ARGS --bind $HYTALE_BIND"

# Transport
[ -n "$HYTALE_TRANSPORT" ] && ARGS="$ARGS --transport $HYTALE_TRANSPORT"

# Auth mode
[ -n "$HYTALE_AUTH_MODE" ] && ARGS="$ARGS --auth-mode $HYTALE_AUTH_MODE"

# Tokens
[ -n "$HYTALE_IDENTITY_TOKEN" ] && ARGS="$ARGS --identity-token $HYTALE_IDENTITY_TOKEN"
[ -n "$HYTALE_SESSION_TOKEN" ] && ARGS="$ARGS --session-token $HYTALE_SESSION_TOKEN"

# Owner
[ -n "$HYTALE_OWNER_NAME" ] && ARGS="$ARGS --owner-name $HYTALE_OWNER_NAME"
[ -n "$HYTALE_OWNER_UUID" ] && ARGS="$ARGS --owner-uuid $HYTALE_OWNER_UUID"

# Assets
[ -n "$HYTALE_ASSETS" ] && ARGS="$ARGS --assets $HYTALE_ASSETS"
[ "$HYTALE_DISABLE_ASSET_COMPARE" = "true" ] && ARGS="$ARGS --disable-asset-compare"
[ "$HYTALE_DISABLE_FILE_WATCHER" = "true" ] && ARGS="$ARGS --disable-file-watcher"

# Universe & Worlds
[ -n "$HYTALE_UNIVERSE" ] && ARGS="$ARGS --universe $HYTALE_UNIVERSE"
[ -n "$HYTALE_WORLD_GEN" ] && ARGS="$ARGS --world-gen $HYTALE_WORLD_GEN"
[ -n "$HYTALE_MIGRATE_WORLDS" ] && ARGS="$ARGS --migrate-worlds $HYTALE_MIGRATE_WORLDS"

# Backup
[ "$HYTALE_BACKUP" = "true" ] && ARGS="$ARGS --backup"
[ -n "$HYTALE_BACKUP_DIR" ] && ARGS="$ARGS --backup-dir $HYTALE_BACKUP_DIR"
[ -n "$HYTALE_BACKUP_FREQUENCY" ] && ARGS="$ARGS --backup-frequency $HYTALE_BACKUP_FREQUENCY"
[ -n "$HYTALE_BACKUP_MAX_COUNT" ] && ARGS="$ARGS --backup-max-count $HYTALE_BACKUP_MAX_COUNT"

# Plugins
[ -n "$HYTALE_MODS" ] && ARGS="$ARGS --mods $HYTALE_MODS"
[ -n "$HYTALE_EARLY_PLUGINS" ] && ARGS="$ARGS --early-plugins $HYTALE_EARLY_PLUGINS"
[ "$HYTALE_ACCEPT_EARLY_PLUGINS" = "true" ] && ARGS="$ARGS --accept-early-plugins"

# Prefabs
[ -n "$HYTALE_PREFAB_CACHE" ] && ARGS="$ARGS --prefab-cache $HYTALE_PREFAB_CACHE"
[ "$HYTALE_DISABLE_CPB_BUILD" = "true" ] && ARGS="$ARGS --disable-cpb-build"

# Validation
[ "$HYTALE_VALIDATE_ASSETS" = "true" ] && ARGS="$ARGS --validate-assets"
[ "$HYTALE_VALIDATE_PREFABS" = "true" ] && ARGS="$ARGS --validate-prefabs"
[ "$HYTALE_VALIDATE_WORLD_GEN" = "true" ] && ARGS="$ARGS --validate-world-gen"
[ "$HYTALE_SHUTDOWN_AFTER_VALIDATE" = "true" ] && ARGS="$ARGS --shutdown-after-validate"

# Advanced
[ "$HYTALE_SINGLEPLAYER" = "true" ] && ARGS="$ARGS --singleplayer"
[ "$HYTALE_BARE" = "true" ] && ARGS="$ARGS --bare"
[ "$HYTALE_ALLOW_OP" = "true" ] && ARGS="$ARGS --allow-op"
[ -n "$HYTALE_FORCE_NETWORK_FLUSH" ] && ARGS="$ARGS --force-network-flush $HYTALE_FORCE_NETWORK_FLUSH"
[ "$HYTALE_DISABLE_SENTRY" = "true" ] && ARGS="$ARGS --disable-sentry"
[ "$HYTALE_EVENT_DEBUG" = "true" ] && ARGS="$ARGS --event-debug"
[ -n "$HYTALE_CLIENT_PID" ] && ARGS="$ARGS --client-pid $HYTALE_CLIENT_PID"

# Boot commands
if [ -n "$HYTALE_BOOT_COMMAND" ]; then
    IFS=',' read -ra COMMANDS <<< "$HYTALE_BOOT_COMMAND"
    for cmd in "${COMMANDS[@]}"; do
        ARGS="$ARGS --boot-command \"$cmd\""
    done
fi

# Logging
[ -n "$HYTALE_LOG" ] && ARGS="$ARGS --log $HYTALE_LOG"

# Schema generation
[ "$HYTALE_GENERATE_SCHEMA" = "true" ] && ARGS="$ARGS --generate-schema"

# Start server
echo "Starting Hytale Server with arguments: $ARGS"
exec java -Xmx${JAVA_MAX_MEMORY:-6G} -Xms${JAVA_MIN_MEMORY:-2G} -jar hytale-server.jar $ARGS
