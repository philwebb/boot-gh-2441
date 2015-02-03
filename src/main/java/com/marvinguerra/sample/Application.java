package com.marvinguerra.sample;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;
import org.springframework.hateoas.config.EnableEntityLinks;

@Configuration
@ComponentScan
@EnableJpaRepositories(value = {"com.marvinguerra.sample.dao.mysql"})
@EnableMongoRepositories(value = {"com.marvinguerra.sample.dao.mongo"})
@EnableEntityLinks
@EnableAutoConfiguration
@ImportResource({
        "securityContext.xml"
})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
