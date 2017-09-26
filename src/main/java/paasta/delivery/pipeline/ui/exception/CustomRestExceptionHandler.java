package paasta.delivery.pipeline.ui.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.exception
 *
 * @author REX
 * @version 1.0
 * @since 9 /22/2017
 */
@ControllerAdvice
public class CustomRestExceptionHandler {

    private static final Logger EXCEPTION_LOGGER = LoggerFactory.getLogger(CustomRestExceptionHandler.class);
    private static final String COMMON_SYSTEM_ERROR_MESSAGE = "시스템 장애가 발생했습니다.";


    /**
     * Handle exception all object.
     *
     * @param ex      the ex
     * @param request the request
     * @return the object
     */
    @ExceptionHandler({Exception.class})
    public Object handleExceptionAll(Exception ex, HttpServletRequest request) {
        String contentType = request.getHeader("content-type");

        EXCEPTION_LOGGER.error("########## Exception Message  :: {}", ex.getMessage());
        EXCEPTION_LOGGER.error("########## Exception Servlet Path :: {}", request.getServletPath());
        EXCEPTION_LOGGER.error("########## Exception Content Type :: {}", contentType);

        if (MediaType.APPLICATION_JSON_VALUE.equals(contentType)) {
            ApiError apiError = new ApiError(HttpStatus.INTERNAL_SERVER_ERROR, COMMON_SYSTEM_ERROR_MESSAGE, "ERROR OCCURRED");
            return new ResponseEntity<>(apiError, new HttpHeaders(), apiError.getStatus());
        } else {
            return new ModelAndView("redirect:/common/error/system-error");
        }
    }

}
