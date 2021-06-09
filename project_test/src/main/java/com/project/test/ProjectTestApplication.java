package com.project.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.project.search.SearchController;
import com.project.test.config.TilesConfig;

@SpringBootApplication
@ComponentScan
@ComponentScan(basePackageClasses = TilesConfig.class)
@ComponentScan(basePackageClasses = SearchController.class)
public class ProjectTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectTestApplication.class, args);
	}

}