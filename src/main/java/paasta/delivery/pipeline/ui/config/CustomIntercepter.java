package paasta.delivery.pipeline.ui.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CustomIntercepter extends HandlerInterceptorAdapter {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomIntercepter.class);

    @Autowired
    CommonService commonService;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {


        String url = request.getRequestURI();


        //Spring-Boot 사용 시
        //1. CustomIntercepter - 설정 주석 해제
        //2. DashboardAuthenticationProcessingFilter - 설정 주석 처리
        //Tomcat 사용 시
        //1. CustomIntercepter - 설정 주석 처리
        //2. DashboardAuthenticationProcessingFilter - 설정 주석 해제

        //Spring-Boot 용
        if(commonService.isLoginUrl(request)){
            LOGGER.info("Spring-Boot");
            request.getSession().invalidate();
        }


        //URL이 다른게 추가될 수 있어...아닌 애들로 체크하게 설정함
        if (!(url.indexOf("/common") >= 0 ||
                url.indexOf("/css") >= 0 ||
                url.indexOf("/webjars") >= 0 ||
                url.indexOf("/js") >= 0
        )) {
            if (SecurityContextHolder.getContext() != null) {
                try {
                    commonService.updateSession();
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/common/error/unauthorized");
                }
            }
        }


        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {

        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

        super.afterCompletion(request, response, handler, ex);
    }

}
