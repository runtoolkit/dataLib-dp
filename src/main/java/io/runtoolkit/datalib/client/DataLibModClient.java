package io.runtoolkit.datalib.client;

import net.fabricmc.api.ClientModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Client-side entry point.
 *
 * CORRECTION: PayloadTypeRegistry.serverboundPlay().register(...) is done ONCE
 * in the common initializer (DataLibMod#onInitialize), which runs on both
 * client and server. Registering again here throws
 * IllegalArgumentException: "already registered" on client launch, since
 * onInitialize() always runs before onInitializeClient().
 */
public class DataLibModClient implements ClientModInitializer {
    private static final Logger LOGGER = LoggerFactory.getLogger("datalib-client");

    @Override
    public void onInitializeClient() {
        DataLibClientCommands.register();
        LOGGER.info("dataLib client bridge initialized.");
    }
}