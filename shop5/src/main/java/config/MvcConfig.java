package config;

import java.util.Properties;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration	//자바 설정 파일로 지정
@ComponentScan(basePackages={"controller","logic","dao","aop","websocket"})
@EnableAspectJAutoProxy	//AOP 설정
@EnableWebMvc	//유효성 검증
public class MvcConfig implements WebMvcConfigurer{
	@Bean	//객체화
	public HandlerMapping handlerMapping() {	//url과 Controller 매핑
		RequestMappingHandlerMapping hm =
				new RequestMappingHandlerMapping();
		hm.setOrder(0);
		return hm;
	}
	@Bean
	public ViewResolver viewResolver() {	//view 결정자
		InternalResourceViewResolver vr =
				new InternalResourceViewResolver();
		vr.setPrefix("/WEB-INF/view/");
		vr.setSuffix(".jsp");
		return vr;
	}
	@Bean
	public MessageSource messageSource() {	//properties 이름 설정
		ResourceBundleMessageSource ms =
				new ResourceBundleMessageSource();
		ms.setBasename("messages");
		return ms;
	}
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver mr = new CommonsMultipartResolver();
		//10M까지 메모리에 저장. 그이상은 임시파일로 저장
		mr.setMaxInMemorySize(10485760);
		//100메가까지 업로드 가능
		mr.setMaxUploadSize(104857600);
		return mr;
	}
	@Bean
	//예외 객체 처리
	public SimpleMappingExceptionResolver exceptionHandelr() {
		SimpleMappingExceptionResolver ser = 
				new SimpleMappingExceptionResolver();
		Properties pr = new Properties();
		pr.put("exception.CartEmptyException","exception");
		pr.put("exception.LoginException","exception");
		pr.put("exception.BoardException","exception");
		ser.setExceptionMappings(pr);
		return ser;
	}
}
