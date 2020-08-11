//package me.survivalking.config;
//
//import javax.servlet.ServletRegistration;
//import javax.servlet.ServletRegistration.Dynamic;
//
//import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
//
//// web.xml 
//public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{
//
//	@Override
//	protected Class<?>[] getRootConfigClasses() {
//		return new Class[] {RootConfig.class};
//	}
//
//	@Override
//	protected Class<?>[] getServletConfigClasses() {
//		return new Class[]{ServletConfig.class};
//	}
//
//	@Override
//	protected String[] getServletMappings() {
//		return new String[] {"/"};
//	}
//	
//	@Override
//	protected void customizeRegistration(ServletRegistration.Dynamic registration) {
//		registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
//	}
//	
//	
//	
//}
