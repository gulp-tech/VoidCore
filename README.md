# VoidCore Bedrock Server

VoidCore — native Bedrock server source that can be built into a runnable server jar. To provide a real Bedrock game server now (login, worlds, chunks, entities, inventory, commands, plugin loading), this repository is based on the upstream **PowerNukkitX 3.0.6** codebase and preserves its LGPL-3.0 license. It is not an implementation of the Bedrock protocol from scratch.

The upstream 3.0.6 release declares Minecraft Bedrock **1.26.60**, protocol **2225**. VoidCore changes the project/artifact identity and includes a Java plugin example. See [UPSTREAM.md](UPSTREAM.md) for provenance and notices.

## Build the server

Requirements: **JDK 21** and internet access for Gradle and project dependencies. From the repository root:

```sh
./gradlew buildSkipChores
```

The runnable jar is generated at:

```text
build/VoidCore.jar
```

On Windows use `gradlew.bat buildSkipChores`. The first Gradle run downloads the wrapper distribution and dependencies. No compiled server binary is committed; compile the source yourself.

## Run

Linux/macOS:

```sh
java -Xms1G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -jar build/VoidCore.jar
```

Windows:

```bat
java -Xms1G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -jar build\VoidCore.jar
```

The first launch creates the server configuration and world files in the current directory. Review the generated EULA/config prompts, then restart. Open the Bedrock server port (default **UDP 19132**) in your host firewall and set the advertised port/MOTD/player limit in `server.properties`.

## Java plugins

The server loads Java plugins compiled for the **PowerNukkitX/Nukkit API**. Put compatible plugin jars in `plugins/` and restart. Java plugins can be built with Maven, Gradle, or Kotlin; the build system does not matter as long as the resulting jar targets the server API and contains a valid `plugin.yml`.

**This is not Bukkit or Paper API.** Bukkit plugins such as EssentialsX, WorldGuard, DeluxeMenus, and Vault are not binary-compatible and will not work unchanged. They need Nukkit/PowerNukkitX ports. ViaVersion is for Java Edition protocol versions and is not needed by a native Bedrock server.

An example Java plugin is in [`examples/hello-plugin`](examples/hello-plugin). Build the server first, then build the example plugin with Gradle or Maven:

```sh
./gradlew buildSkipChores
./gradlew -p examples/hello-plugin build
# alternatively: cd examples/hello-plugin && mvn package
```

Copy `examples/hello-plugin/build/libs/voidcore-hello-plugin-1.0.0.jar` (Gradle) or `examples/hello-plugin/target/voidcore-hello-plugin.jar` (Maven) to the server's `plugins/` directory.

## Java plugin API example

```java
package example;

import org.powernukkitx.plugin.PluginBase;

public final class HelloVoidCore extends PluginBase {
    @Override
    public void onEnable() {
        getLogger().info("Hello from VoidCore / PowerNukkitX API!");
    }
}
```

Plugin metadata is in `plugin.yml`; see the example project. For plugins that use Nukkit events, commands, inventories, permissions, and scheduler, use the API classes shipped in `VoidCore.jar`.

## Important limits

- This is a VoidCore-branded downstream build of PowerNukkitX, not a brand-new protocol/game implementation. Upstream notices and LGPL-3.0 terms remain in force.
- Compatibility is with Nukkit/PowerNukkitX plugins, not Bukkit/Paper plugins. Supporting the named Bukkit plugins would require ports or a substantial Bukkit compatibility layer and is not part of this build.
- The Bedrock protocol version is inherited from the upstream 3.0.6 source. Protocol compatibility can change with Minecraft updates; verify against the Bedrock clients you intend to support.
