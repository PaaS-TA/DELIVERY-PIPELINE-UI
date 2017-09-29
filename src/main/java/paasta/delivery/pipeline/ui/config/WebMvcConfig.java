package paasta.delivery.pipeline.ui.config;

import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.boot.web.servlet.ErrorPageRegistrar;
import org.springframework.boot.web.servlet.ErrorPageRegistry;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.config
 *
 * @author REX
 * @version 1.0
 * @since 5 /10/2017
 */
@Configuration
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }


    /**
     * View resolver view resolver.
     *
     * @return the view resolver
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/jsp");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }


    /**
     * Message source reloadable resource bundle message source.
     *
     * @return the reloadable resource bundle message source
     */
    @Bean
    public ReloadableResourceBundleMessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:locale/messages");
        return messageSource;
    }


    /**
     * Message source accessor message source accessor.
     *
     * @param messageSource the message source
     * @return the message source accessor
     */
    @Bean
    public MessageSourceAccessor messageSourceAccessor(MessageSource messageSource) {
        return new MessageSourceAccessor(messageSource);
    }


    /**
     * Error page registrar error page registrar.
     *
     * @return the error page registrar
     */
    @Bean
    public ErrorPageRegistrar errorPageRegistrar() {
        return new MyErrorPageRegistrar();
    }


    /**
     * Site mesh filter filter registration bean.
     *
     * @return the filter registration bean
     */
    @Bean
    public FilterRegistrationBean siteMeshFilter() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(new WebSiteMeshFilter());
        return filterRegistrationBean;
    }


    private static class MyErrorPageRegistrar implements ErrorPageRegistrar {
        @Override
        public void registerErrorPages(ErrorPageRegistry registry) {
            registry.addErrorPages(new ErrorPage(HttpStatus.UNAUTHORIZED, "/common/error/unauthorized"));
            registry.addErrorPages(new ErrorPage(HttpStatus.FORBIDDEN, "/common/error/forbidden"));
            registry.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND,"/common/error/not-found"));
            registry.addErrorPages(new ErrorPage(HttpStatus.BAD_REQUEST,"/common/error/not-found"));
            registry.addErrorPages(new ErrorPage(HttpStatus.CONFLICT,"/common/error/system-error"));
            registry.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR,"/common/error/system-error"));
        }
    }


    @Bean
    CustomIntercepter customIntercepter() {
        return new CustomIntercepter();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(customIntercepter());
    }

}
