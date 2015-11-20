package name.abhijitsarkar.javaee.hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;

/**
 * @author Abhijit Sarkar
 */
@SpringBootApplication
public class HelloWorldApp extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(HelloWorldApp.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(HelloWorldApp.class, args);
    }
}
