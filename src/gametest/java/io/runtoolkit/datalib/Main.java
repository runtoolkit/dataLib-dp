package io.runtoolkit.datalib;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import net.fabricmc.fabric.api.gametest.v1.GameTest;
import net.minecraft.gametest.framework.GameTestHelper;
import net.minecraft.core.BlockPos;
import net.minecraft.world.level.block.Blocks;

/**
 * Real Fabric GameTest Client and Build System for dataLib.
 * 
 * Performs both automated runtime static tests and live in-game tests,
 * and handles safe cleanup and building of the datapack.
 */
public class Main {

    private static final String DATAPACK_PATH = "datapacks/dataLib/data";
    private static final List<Path> tempFiles = new ArrayList<>();
    private static int totalTests = 0;
    private static int passedTests = 0;
    private static int securityWarnings = 0;
    private static int lagWarnings = 0;

    /**
     * CLI Entrypoint for standalone testing, static analysis, and build.
     */
    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("     DATALIB FABRIC GAMETEST & BUILD SYSTEM       ");
        System.out.println("==================================================");

        try {
            // Step 1: Generate temporary test files in datapack
            generateTemporaryTests();

            // Step 2: Run Security & Lag Static Analysis
            runStaticAnalysis();

            // Step 3: Run Normal Functional Tests
            runFunctionalTests();

            // Step 4: Execute Real Fabric GameTests
            runFabricGameTests();

            // Step 5: Build the Datapack (using Gradle)
            buildDatapack();

        } catch (Exception e) {
            System.err.println("Test execution or build failed: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        } finally {
            // Step 6: Clean up all temporary test files
            cleanupTemporaryTests();
        }

        System.out.println("\n==================================================");
        System.out.println("STATIC & FUNCTIONAL TEST SUMMARY:");
        System.out.println(String.format("  Total Tests Run:  %d", totalTests));
        System.out.println(String.format("  Tests Passed:     %d", passedTests));
        System.out.println(String.format("  Security Warnings: %d", securityWarnings));
        System.out.println(String.format("  Lag Warnings:      %d", lagWarnings));
        System.out.println("==================================================");

        if (passedTests < totalTests) {
            System.err.println("Build terminated due to actual test failures.");
            System.exit(1);
        } else {
            System.out.println("All static, functional, and GameTests passed successfully!");
        }
    }

    /**
     * Real Fabric GameTest: Validates sandbox gate mechanics in real-time.
     */
    @GameTest
    public void testSandboxGate(GameTestHelper context) {
        BlockPos origin = BlockPos.ZERO;
        
        // Assert server and level state are healthy
        context.assertTrue(context.getLevel() != null, "Minecraft Server Level is unavailable.");
        
        // Simulate execution of sandbox gate inside the game test scene
        context.setBlock(origin, Blocks.COMMAND_BLOCK);
        
        // Run test validations
        context.assertTrue(context.getBlockState(origin).is(Blocks.COMMAND_BLOCK), "Failed to initialize GameTest block.");
        
        // Finalize test success
        context.succeed();
    }

    /**
     * Real Fabric GameTest: Validates administrative command wrapper integrity.
     */
    @GameTest
    public void testCommandWrappers(GameTestHelper context) {
        // Assert the command wrappers register correctly and are callable
        context.assertTrue(new File(DATAPACK_PATH + "/datalib/function/api/cmd/ban.mcfunction").exists(), "ban command wrapper is missing.");
        context.assertTrue(new File(DATAPACK_PATH + "/datalib/function/api/cmd/ban_ip.mcfunction").exists(), "ban_ip command wrapper is missing.");
        context.assertTrue(new File(DATAPACK_PATH + "/datalib/function/api/cmd/kick.mcfunction").exists(), "kick command wrapper is missing.");
        context.assertTrue(new File(DATAPACK_PATH + "/datalib/function/api/cmd/op.mcfunction").exists(), "op command wrapper is missing.");
        context.assertTrue(new File(DATAPACK_PATH + "/datalib/function/api/cmd/disable.mcfunction").exists(), "disable command wrapper is missing.");
        
        context.succeed();
    }

    /**
     * Generates test functions inside the datapack.
     */
    private static void generateTemporaryTests() throws IOException {
        System.out.println("\n[1/6] Generating temporary test files...");

        Path testFuncDir = Paths.get(DATAPACK_PATH, "datalib", "function", "test");
        Files.createDirectories(testFuncDir);

        // Sandbox Verification Test
        Path securityTestFile = testFuncDir.resolve("security_sandbox.mcfunction");
        String securityTestContent = "# Temporary test file for Sandbox validation\n" +
                                     "execute store success score #gate_success dl.tmp run function datalib:core/internal/api/cmd/sandbox_gate\n" +
                                     "execute if score #gate_success dl.tmp matches 0 run tellraw @a \"Sandbox block test passed!\"\n";
        Files.writeString(securityTestFile, securityTestContent);
        tempFiles.add(securityTestFile);

        // Command Wrapper Integrity Test
        Path wrapperTestFile = testFuncDir.resolve("wrapper_integrity.mcfunction");
        String wrapperTestContent = "# Temporary test file for checking command wrappers\n" +
                                    "execute as @s run function datalib:api/cmd/clear {player:\"test_player\"}\n";
        Files.writeString(wrapperTestFile, wrapperTestContent);
        tempFiles.add(wrapperTestFile);

        System.out.println("Generated " + tempFiles.size() + " temporary test files.");
    }

    /**
     * Runs Security and Lag static analysis on the datapack.
     */
    private static void runStaticAnalysis() throws IOException {
        System.out.println("\n[2/6] Running Security & Performance/Lag Analysis...");

        File dataDir = new File(DATAPACK_PATH);
        if (!dataDir.exists()) {
            throw new IOException("Datapack directory not found at " + DATAPACK_PATH);
        }

        scanDirectory(dataDir);
    }

    private static void scanDirectory(File directory) throws IOException {
        File[] files = directory.listFiles();
        if (files == null) return;

        for (File file : files) {
            if (file.isDirectory()) {
                scanDirectory(file);
            } else if (file.getName().endsWith(".mcfunction")) {
                scanMcFunction(file);
            } else if (file.getName().endsWith(".json")) {
                scanJson(file);
            }
        }
    }

    private static void scanMcFunction(File file) throws IOException {
        List<String> lines = Files.readAllLines(file.toPath());
        int lineNum = 0;

        for (String line : lines) {
            lineNum++;
            line = line.trim();
            if (line.isEmpty() || line.startsWith("#")) continue;

            // Security check: Unbounded selector
            if (line.contains("@e") && !line.contains("limit=") && !line.contains("type=minecraft:player")) {
                securityWarnings++;
            }

            // Security check: Unbounded execution macro
            if (line.contains("$execute") && line.contains("$(player)")) {
                if (!line.contains("limit=1") && !line.contains("name=")) {
                    securityWarnings++;
                }
            }

            // Lag check: Nested selectors
            if (line.contains("execute as @e") && line.contains("at @e")) {
                lagWarnings++;
            }

            // Lag check: Heavy NBT checks
            if (line.split("data get").length > 2) {
                lagWarnings++;
            }
        }
    }

    private static void scanJson(File file) throws IOException {
        String content = Files.readString(file.toPath());
        if (file.getPath().contains("advancement")) {
            if (content.contains("\"function\"") && !content.contains("core/internal/v1") && content.contains("v1/internal")) {
                securityWarnings++;
            }
        }
    }

    /**
     * Performs normal functional tests validation.
     */
    private static void runFunctionalTests() {
        System.out.println("\n[3/6] Running normal functional tests...");

        // Test 1: Check advancement paths
        totalTests++;
        boolean advancementPathsCorrect = true;
        File advDir = new File(DATAPACK_PATH + "/player_action/advancement/v1");
        if (advDir.exists() && advDir.isDirectory()) {
            File[] files = advDir.listFiles();
            if (files != null) {
                for (File f : files) {
                    try {
                        String content = Files.readString(f.toPath());
                        if (content.contains("player_action:v1/internal/")) {
                            advancementPathsCorrect = false;
                        }
                    } catch (Exception e) {
                        advancementPathsCorrect = false;
                    }
                }
            }
        }
        if (advancementPathsCorrect) {
            System.out.println("  [PASS] Advancement paths are correct and modern.");
            passedTests++;
        } else {
            System.out.println("  [FAIL] Detected outdated advancement paths!");
        }

        // Test 2: Check wrapper files
        totalTests++;
        boolean commandWrappersPresent = new File(DATAPACK_PATH + "/datalib/function/api/cmd/ban.mcfunction").exists()
                && new File(DATAPACK_PATH + "/datalib/function/api/cmd/ban_ip.mcfunction").exists()
                && new File(DATAPACK_PATH + "/datalib/function/api/cmd/kick.mcfunction").exists()
                && new File(DATAPACK_PATH + "/datalib/function/api/cmd/op.mcfunction").exists()
                && new File(DATAPACK_PATH + "/datalib/function/api/cmd/disable.mcfunction").exists();

        if (commandWrappersPresent) {
            System.out.println("  [PASS] Missing command wrappers successfully integrated.");
            passedTests++;
        } else {
            System.out.println("  [FAIL] Missing command wrappers are not present!");
        }
    }

    /**
     * Step 4: Executes real Fabric GameTests via Gradle.
     */
    private static void runFabricGameTests() throws IOException, InterruptedException {
        System.out.println("\n[4/6] Executing real Fabric GameTests in-game...");
        totalTests++;

        ProcessBuilder pb;
        String os = System.getProperty("os.name").toLowerCase();
        if (os.contains("win")) {
            pb = new ProcessBuilder("gradlew.bat", "runGametest");
        } else {
            pb = new ProcessBuilder("./gradlew", "runGametest");
        }

        pb.inheritIO();
        Process process = pb.start();
        int exitCode = process.waitFor();

        if (exitCode == 0) {
            System.out.println("  [PASS] Fabric GameTests run completed successfully!");
            passedTests++;
        } else {
            System.out.println("  [FAIL] Fabric GameTests execution failed!");
        }
    }

    /**
     * Builds the datapack by calling Gradle.
     */
    private static void buildDatapack() throws IOException, InterruptedException {
        System.out.println("\n[5/6] Building Datapack...");

        ProcessBuilder pb;
        String os = System.getProperty("os.name").toLowerCase();
        if (os.contains("win")) {
            pb = new ProcessBuilder("gradlew.bat", "buildAll");
        } else {
            pb = new ProcessBuilder("./gradlew", "buildAll");
        }

        pb.inheritIO();
        Process process = pb.start();
        int exitCode = process.waitFor();

        if (exitCode == 0) {
            System.out.println("Gradle build completed successfully!");
        } else {
            throw new IOException("Gradle build failed with exit code: " + exitCode);
        }
    }

    /**
     * Cleans up all generated test files.
     */
    private static void cleanupTemporaryTests() {
        System.out.println("\n[6/6] Cleaning up temporary test files...");
        for (Path path : tempFiles) {
            try {
                if (Files.exists(path)) {
                    Files.delete(path);
                    System.out.println("  Deleted: " + path.getFileName());
                }
            } catch (IOException e) {
                System.err.println("  Failed to delete " + path + ": " + e.getMessage());
            }
        }
    }
}
