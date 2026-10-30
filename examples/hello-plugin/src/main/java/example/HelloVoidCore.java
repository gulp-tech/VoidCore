package example;

import org.powernukkitx.plugin.PluginBase;

/** Small smoke-test plugin proving that a Java extension can be built and loaded. */
public final class HelloVoidCore extends PluginBase {
    @Override
    public void onEnable() {
        getLogger().info("Hello from the VoidCore Java plugin API!");
    }

    @Override
    public void onDisable() {
        getLogger().info("HelloVoidCore stopped.");
    }
}
