package paasta.delivery.pipeline.ui.exception;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.exception
 *
 * @author REX
 * @version 1.0
 * @since 9 /25/2017
 */
@Controller
public class CustomErrorController implements ErrorController {

    private static final String ERROR_PATH = "/error";


    /**
     * Error model and view.
     *
     * @return the model and view
     */
    @RequestMapping(ERROR_PATH)
    public ModelAndView error() {
        return new ModelAndView("redirect:/common/error/system-error");
    }


    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }

}