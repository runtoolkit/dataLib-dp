package io.runtoolkit.datalib.client;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.networking.v1.PayloadTypeRegistry;
import io.runtoolkit.datalib.DataLibConfigPayload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Client-side entry point.
 *
 * IMPORTANT CORRECTION: PayloadTypeRegistry.serverboundPlay() (formerly playC2S(),
 * renamed in the Fabric API 26.1 official-mappings port) is a SEPARATE registry
 * object on the client vs. the server (direction-based, not a single
 * process-wide registration) — the client has to register on THIS side too
 * in order to encode the C2S payload it sends; the server only uses its own
 * registration when decoding. So registration must happen in BOTH DataLibMod
 * (server/common) AND here (client) — an earlier comment said "register in
 * one place only", that was wrong and has been corrected.
 */
public class DataLibModClient implements ClientModInitializer {
    private static final Logger LOGGER = LoggerFactory.getLogger("datalib-client");

    @Override
    public void onInitializeClient() {
        PayloadTypeRegistry.serverboundPlay().register(DataLibConfigPayload.TYPE, DataLibConfigPayload.CODEC);
        DataLibClientCommands.register();
        LOGGER.info("dataLib client bridge initialized.");
    }
}
