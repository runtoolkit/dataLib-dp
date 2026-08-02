package io.runtoolkit.datalib.client;

import io.runtoolkit.datalib.DataLibConfigPayload;
import net.fabricmc.fabric.api.client.networking.v1.ClientPlayNetworking;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.components.EditBox;
import net.minecraft.client.gui.components.FittingMultiLineTextWidget;
import net.minecraft.client.gui.components.MultiLineTextWidget;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

/**
 * Client-side admin screen for the dataLib config menu.
 *
 * This class uses the verified (via javap) 26.3-snapshot-5 API:
 *   - FittingMultiLineTextWidget(int x, int y, int width, int height, Component, Font)
 *   - MultiLineTextWidget(Component, Font) + setMaxWidth/setCentered
 *   - EditBox(Font, int x, int y, int width, int height, Component)
 *   - Button.Builder(Component, OnPress).bounds(x,y,w,h).build()
 *
 * UNVERIFIED PART: the full list of real config keys (seen referenced in
 * api/config/namespace_list.mcfunction and the runtime/config/* functions)
 * is not used here yet — this screen offers free-text key/value entry, not
 * a dropdown/predefined key list. To list the real schema you'd need to
 * look at the contents of api/config/namespace_list.mcfunction on the
 * datapack side.
 */
public class DataLibConfigScreen extends Screen {

    private final Screen parent;
    private EditBox keyBox;
    private EditBox valueBox;

    public DataLibConfigScreen(Screen parent) {
        super(Component.literal("dataLib Config"));
        this.parent = parent;
    }

    @Override
    protected void init() {
        int centerX = this.width / 2;

        // Title: single-line, centered MultiLineTextWidget.
        MultiLineTextWidget title = new MultiLineTextWidget(
                Component.literal("dataLib — Config"), this.font
        );
        title.setCentered(true);
        title.setMaxWidth(this.width - 40);
        this.addRenderableOnly(title);

        // Description / status area: FittingMultiLineTextWidget — a fixed
        // x/y/width/height area with its own scrollbar.
        FittingMultiLineTextWidget infoArea = new FittingMultiLineTextWidget(
                20, 30, this.width - 40, 60,
                Component.literal(
                        "Enter a config key (e.g. sandbox.enabled) and its new value, "
                        + "then press Save. Real authorization and validation happen "
                        + "server-side in the datalib:runtime/config/set function."
                ),
                this.font
        );
        this.addRenderableWidget(infoArea);

        int fieldsY = 100;

        this.keyBox = new EditBox(this.font, centerX - 150, fieldsY, 300, 20,
                Component.literal("Config key"));
        this.keyBox.setHint(Component.literal("e.g. sandbox.enabled"));
        this.addRenderableWidget(this.keyBox);

        this.valueBox = new EditBox(this.font, centerX - 150, fieldsY + 28, 300, 20,
                Component.literal("Value"));
        this.valueBox.setHint(Component.literal("e.g. true"));
        this.addRenderableWidget(this.valueBox);

        this.addRenderableWidget(
                Button.builder(Component.literal("Save"), button -> this.onSave())
                        .bounds(centerX - 150, fieldsY + 60, 145, 20)
                        .build()
        );

        this.addRenderableWidget(
                Button.builder(Component.literal("Cancel"), button -> this.onClose())
                        .bounds(centerX + 5, fieldsY + 60, 145, 20)
                        .build()
        );
    }

    private void onSave() {
        String key = this.keyBox.getValue();
        String value = this.valueBox.getValue();
        if (key.isBlank()) {
            return;
        }
        this.sendConfigUpdate(key, value);
    }

    /**
     * Called to send a config change to dataLib. Networking API verified:
     * ClientPlayNetworking.send(CustomPacketPayload).
     */
    private void sendConfigUpdate(String key, String value) {
        ClientPlayNetworking.send(new DataLibConfigPayload(key, value));
    }

    @Override
    public void onClose() {
        // NOTE: there is no Minecraft.setScreen(Screen) method (verified via
        // javap) — the real method is setScreenAndShow(Screen).
        this.minecraft.setScreenAndShow(this.parent);
    }
}
