package com.project.test;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //현재클래스 설정 모든 결과 xml 파일 <bean
@ComponentScan
@ComponentScan
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
    	registry.addResourceHandler("/upload/**")//url 설정
                .addResourceLocations("file:/usr/mydir/upload/");//실제경로
//        registry.addResourceHandler("/upload/**")//url 설정
//        		.addResourceLocations("file:///C:/upload/");//실제경로
        registry.addResourceHandler("/profile/**")//url 설정
				.addResourceLocations("file:/usr/mydir/profile/");//실제경로
//        registry.addResourceHandler("/profile/**")//url 설정
//        		.addResourceLocations("file:///C:/profile/");//실제경로
    }
}
