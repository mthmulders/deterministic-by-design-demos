package it.mulders.deterministicbydesign.demo4;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class App {
    static {
        System.setProperty("slf4j.internal.verbosity", "WARN");
    }
    
    private static final Logger log = LoggerFactory.getLogger(App.class);

    public static void main(String[] args) {
        log.info("Application started.");
        final Properties config = loadConfiguration();
        log.info("Using currency: {}", config.getProperty("application.currency"));
    }

    private static Properties loadConfiguration() {
        Properties properties = new Properties();
        try (InputStream input = App.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                log.error("Sorry, unable to find config.properties");
                return properties;
            }
            properties.load(input);
        } catch (IOException ex) {
            log.error("Error loading configuration", ex);
        }
        return properties;
    }
}