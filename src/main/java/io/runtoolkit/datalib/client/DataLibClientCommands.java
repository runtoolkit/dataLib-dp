package io.runtoolkit.datalib.client;

import net.fabricmc.fabric.api.client.command.v2.ClientCommandRegistrationCallback;
import net.fabricmc.fabric.api.client.command.v2.ClientCommands;
import net.minecraft.client.Minecraft;

/**
 * Registers the "/datalibconfig" client command — opens DataLibConfigScreen
 * when run.
 *
 * Real API (verified via javap, fabric-command-api-v2 3.1.0+26.3):
 *   - ClientCommandRegistrationCallback.EVENT.register((dispatcher, ctx) -> ...)
 *   - ClientCommands.literal(String) → LiteralArgumentBuilder<FabricClientCommandSource>
 *
 * NOTE: this command works purely client-side (just opens a Screen) without
 * any server communication — the send to the server only happens when the
 * "Save" button is pressed (DataLibConfigScreen.onSave).
 */
public final class DataLibClientCommands {
    private DataLibClientCommands() {
    }

    public static void register() {
        ClientCommandRegistrationCallback.EVENT.register((dispatcher, registryAccess) ->
                dispatcher.register(
                        ClientCommands.literal("datalibconfig")
                                .executes(context -> {
                                    // NOTE: opening the screen synchronously inside the
                                    // command's .executes() callback gets immediately
                                    // closed again, because Minecraft closes the
                                    // chat/command screen right after command execution
                                    // completes, overwriting whatever screen we just set.
                                    // Deferring via client.execute() runs this on the
                                    // next client tick, after that close has happened.
                                    Minecraft client = Minecraft.getInstance();
                                    client.execute(() -> client.setScreenAndShow(new DataLibConfigScreen(null)));
                                    return 1;
                                })
                )
        );
    }
}
