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
import java.awt.*;


public class CustomIntercepter extends HandlerInterceptorAdapter {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomIntercepter.class);

    @Autowired
    CommonService commonService;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        LOGGER.info("REQUEST URL : " + url);
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        LOGGER.info("#######################################################");
        String urls[] = url.split("/");



        /*
        * 로그아웃 페이지가 없는 관계로
        * /dashboard/serviceinstanceid URL은 로그아웃과 로그인을 동시에 진행하도록
        * 설정함
        */

        if (urls != null) {
            if (urls.length == 3) {
                if (!(urls[1].indexOf("dashboard") < 0)) {
                    LOGGER.info("#######################################################");
                    LOGGER.info("LOGOUT ");
                    LOGGER.info("#######################################################");
                    request.getSession().invalidate();
                    SecurityContextHolder.clearContext();
                }
            }
        }


        //URL이 다른게 추가될 수 있어...아닌 애들로 체크하게 설정함
        if (!(url.indexOf("/common") >= 0 ||
                url.indexOf("/css") >= 0 ||
                url.indexOf("/webjars") >= 0 ||
                url.indexOf("/js") >= 0
        )) {
        } else {
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
