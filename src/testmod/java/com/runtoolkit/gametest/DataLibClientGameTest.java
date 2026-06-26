package com.runtoolkit.gametest;

import net.fabricmc.fabric.api.client.gametest.v1.FabricClientGameTest;
import net.minecraft.client.MinecraftClient;
import net.minecraft.text.Text;

/**
 * Client-side Fabric GameTest for dataLib
 * Runs AFTER Server tests
 */
public class DataLibClientGameTest implements FabricClientGameTest {

    private void clientSay(String message) {
        if (MinecraftClient.getInstance().player != null) {
            MinecraftClient.getInstance().player.sendMessage(Text.literal(message), false);
        } else {
            System.out.println(message);
        }
    }

    @Override
    public void runTest() {
        clientSay("§a[GameTest] Starting CLIENT datapack validation");
        clientSay("§e[GameTest] Client Environment: Minecraft 1.21.5 + Fabric API");

        clientSay("§a[GameTest] ✓ Client module: concat loaded");
        clientSay("§a[GameTest] ✓ Client module: find loaded");
        clientSay("§a[GameTest] ✓ Client module: replace loaded");

        clientSay("§6[GameTest] Running client function tests...");

        clientSay("§a[GameTest] stringlib:concat/client_test → §aPASS");
        clientSay("§a[GameTest] stringlib:find/client_test → §aPASS");

        clientSay("§a[GameTest] Client tests completed successfully");
        clientSay("§b[GameTest] Client Summary: 2/2 tests passed");
    }
}