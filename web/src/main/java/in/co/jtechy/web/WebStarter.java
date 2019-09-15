package in.co.jtechy.web;

import in.co.jtechy.persistance.audit.AuditorAwareImpl;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.*;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = {"in.co.jtechy.persistance"})
@EntityScan(basePackages = "in.co.jtechy.domain")
@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorAware")
@ImportResource({"classpath*:applicationContext.xml"})
public class WebStarter extends SpringBootServletInitializer {

    @Bean
    public AuditorAware<String> auditorAware() {
        return new AuditorAwareImpl();
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(WebStarter.class);
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(WebStarter.class, args);
    }

}
