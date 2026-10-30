package org.powernukkitx;

public final class JarStart {
    /**
     * If the user uses java -jar to start the server.
     */
    private static boolean usingJavaJar = false;

    public static void main(String[] args) {
        try {
            Thread.currentThread().getContextClassLoader().loadClass("joptsimple.OptionSpec");
        } catch (ClassNotFoundException | java.lang.NoClassDefFoundError e) {
            // There are no libs now. It means that even logger cannot be used.
            System.out.println("Required runtime libraries were not found. VoidCore cannot start and will now exit.");
            System.out.println("Build the runnable shadow jar with ./gradlew buildSkipChores.");
            System.out.println("VoidCore is based on PowerNukkitX; see UPSTREAM.md for provenance.");
            return;
        }
        usingJavaJar = true;
        PowerNukkitX.main(args);
    }

    public static boolean isUsingJavaJar() {
        return usingJavaJar;
    }

    // Method to reset the state for testing
    public static void resetUsingJavaJar() {
        usingJavaJar = false;
    }
}
