package com.warehouse.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;



	@Configuration
	public class AppConfig {

	    @Bean(name = "multipartResolver")
	    public CommonsMultipartResolver multipartResolver() {
	        
	        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
	        resolver.setMaxUploadSize(50 * 1024 * 1024); 
	        resolver.setDefaultEncoding("UTF-8");

	        return resolver;
	    }
	}


