package io.runtoolkit.datalib;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.networking.v1.PayloadTypeRegistry;
import net.fabricmc.fabric.api.networking.v1.ServerPlayNetworking;
import net.minecraft.server.level.ServerPlayer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DataLibMod implements ModInitializer {
    public static final String MOD_ID = "datalib";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        PayloadTypeRegistry.serverboundPlay().register(DataLibConfigPayload.TYPE, DataLibConfigPayload.CODEC);

        ServerPlayNetworking.registerGlobalReceiver(DataLibConfigPayload.TYPE, (payload, context) -> {
            ServerPlayer player = context.player();
            context.server().execute(() -> {
                // NOTE: this does NOT bypass dataLib's own permission/validation
                // chain (Security Levels etc.) — this mod only triggers the same
                // command interface from the client, real authorization must still
                // happen on the datapack side.
                String key = payload.key();
                String value = payload.value();

                LOGGER.info("dataLib config_set: {} set {} = {}",
                        player.getGameProfile().name(), key, value);

                // UNVERIFIED ASSUMPTION: datalib:runtime/config/set is a macro function
                // (uses $(key), $(value) — verified from set.mcfunction) but no call
                // site for it was found anywhere in the repo (grep came back empty).
                // The "with storage" call below relies on Minecraft's general/standard
                // macro invocation rule (function ns:path with storage ns:path, field
                // names in storage match $(...) placeholders) — it is NOT a verified
                // example usage from the datapack. Update this if the real call
                // convention becomes clear from the dataLib repo.
                // NOTE (V2 reorg): path updated from datalib:core/config/set to
                // datalib:runtime/config/set — config/* moved under runtime/ since
                // it is part of dataLib's own runtime engine, not public API surface.
                context.server().getCommands().performPrefixedCommand(
                        player.createCommandSourceStack(),
                        "data modify storage datalib:input key set value \"" + key.replace("\"", "\\\"") + "\""
                );
                context.server().getCommands().performPrefixedCommand(
                        player.createCommandSourceStack(),
                        "data modify storage datalib:input value set value \"" + value.replace("\"", "\\\"") + "\""
                );
                context.server().getCommands().performPrefixedCommand(
                        player.createCommandSourceStack(),
                        "function datalib:runtime/config/set with storage datalib:input"
                );
            });
        });

        LOGGER.info("dataLib config bridge mod initialized.");
    }
}