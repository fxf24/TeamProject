package com.project.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.project.search.SearchController;

import com.project.search.SearchController;

@SpringBootApplication
@ComponentScan(basePackageClasses = SearchController.class)
public class ProjectTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectTestApplication.class, args);
	}

}
