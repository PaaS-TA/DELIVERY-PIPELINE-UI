package paasta.delivery.pipeline.ui.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.error
 *
 * @author REX
 * @version 1.0
 * @since 5 /12/2017
 */
@Controller
@RequestMapping("/common/error")
public class ExceptionHandlingController {

    /**
     * Custom 401 error model and view.
     *
     * @param req the req
     * @return the model and view
     */
    @RequestMapping("/unauthorized")
    public ModelAndView custom401Error(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("url", req.getRequestURL());
        mav.setViewName("/error/error401");
        return mav;
    }


    /**
     * Custom 403 error model and view.
     *
     * @param req the req
     * @return the model and view
     */
    @RequestMapping("/forbidden")
    public ModelAndView custom403Error(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("url", req.getRequestURL());
        mav.setViewName("/error/error403");
        return mav;
    }


    /**
     * Custom 404 error model and view.
     *
     * @param req the req
     * @return the model and view
     */
    @RequestMapping("/not-found")
    public ModelAndView custom404Error(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("url", req.getRequestURL());
        mav.setViewName("/error/error404");
        return mav;
    }


    /**
     * Custom 500 error model and view.
     *
     * @param req the req
     * @return the model and view
     */
    @RequestMapping("/system-error")
    public ModelAndView custom500Error(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("url", req.getRequestURL());
        mav.setViewName("/error/error500");
        return mav;
    }

}
