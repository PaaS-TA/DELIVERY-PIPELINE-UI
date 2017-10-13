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
        try {

            String url = request.getRequestURI();

            LOGGER.info("#######################################################");
            LOGGER.info("#######################################################");
            LOGGER.info("REQUEST URL : " + url);
            LOGGER.info("#######################################################");
            LOGGER.info("#######################################################");

            String urls[] = url.split("/");
            if (urls != null) {
                if (urls.length == 3) {
                    if (urls[0].indexOf("/dashboard") < 0) {

                        request.getSession().invalidate();
                        //Tomcat 용
                        response.sendRedirect(url + "/pipeline/dashboard");
                        return super.preHandle(request, response, handler);
                    }
                }
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
                        request.getSession().invalidate();
                        response.sendRedirect(request.getContextPath() + "/common/error/unauthorized");
                    }
                }
            }
        } catch (Exception e) {

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
