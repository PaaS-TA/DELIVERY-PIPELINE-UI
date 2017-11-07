package paasta.delivery.pipeline.ui.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import paasta.delivery.pipeline.ui.cf.info.CfInfo;
import paasta.delivery.pipeline.ui.cf.url.CfUrl;
import paasta.delivery.pipeline.ui.job.Job;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUse;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Enumeration;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.common
 *
 * @author REX
 * @version 1.0
 * @since 5 /10/2017
 */
@Aspect
@Service
public class AspectService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AspectService.class);
    private final CommonService commonService;

    /**
     * Instantiates a new Aspect service.
     *
     * @param commonService the common service
     */
    @Autowired
    public AspectService(CommonService commonService) {this.commonService = commonService;}

    /**
     * On before log service access.
     *
     * @param joinPoint the join point
     */
    @Before("execution(* paasta.delivery..*Service.*(..))")
    public void onBeforeLogServiceAccess(JoinPoint joinPoint) {
        LOGGER.warn("######## ON BEFORE SERVICE ACCESS :: {}", joinPoint);
    }


    /**
     * On before log controller access.
     *
     * @param joinPoint the join point
     */
    @Before("execution(public * paasta.delivery..*Controller.*(..))")
    public void onBeforeLogControllerAccess(JoinPoint joinPoint) {
        LOGGER.warn("#### ON BEFORE CONTROLLER ACCESS :: {}", joinPoint);
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

        LOGGER.warn("## Entering in Method:  {}", joinPoint.getSignature().getName());
        LOGGER.warn("## Class Name:  {}", joinPoint.getSignature().getDeclaringTypeName());
        LOGGER.warn("## Arguments:  {}", Arrays.toString(joinPoint.getArgs()));
        LOGGER.warn("## Target class:  {}", joinPoint.getTarget().getClass().getName());

        if (null != request) {
            LOGGER.warn("## Request Path info:  {}", request.getServletPath());
            LOGGER.warn("## Method Type:  {}", request.getMethod());
            LOGGER.warn("================================================================================");
            LOGGER.warn("Start Header Section of request");
            Enumeration headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String headerName = (String) headerNames.nextElement();
                String headerValue = request.getHeader(headerName);
                LOGGER.warn("  Header Name: {} || Header Value: {}", headerName, headerValue);
            }
            LOGGER.warn("End Header Section of request");
            LOGGER.warn("================================================================================");
        }
    }


    /**
     * On around set user id object.
     *
     * @param joinPoint the join point
     * @return the object
     */
    @Around("execution(* paasta.delivery.pipeline.ui.*.*Service.setCreate*(..)) || execution(* paasta.delivery.pipeline.ui.*.*Service.setUpdate*(..)) " +
            " || execution(* paasta.delivery.pipeline.ui.*.*.*Service.setCreate*(..)) || execution(* paasta.delivery.pipeline.ui.*.*.*Service.setUpdate*(..)) " +
            " || execution(* paasta.delivery.pipeline.ui.*.*Service.setReplicate*(..))")
    public Object onAroundSetUserId(ProceedingJoinPoint joinPoint) {
        Object resultObject = null;

        try {
            for (Object obj : joinPoint.getArgs()) {
                if (obj instanceof Job
                        || obj instanceof InstanceUse
                        || obj instanceof CfInfo
                        || obj instanceof CfUrl) {
                    Class<?> aClass = obj.getClass();
                    Method methodSetUserId = aClass.getMethod("setUserId", String.class);
                    methodSetUserId.invoke(obj, commonService.getUserId());
                }
            }

            resultObject = joinPoint.proceed();

        } catch (NoSuchMethodException e) {
            LOGGER.error("NoSuchMethodException :: {}", e);
        } catch (IllegalAccessException e) {
            LOGGER.error("IllegalAccessException :: {}", e);
        } catch (InvocationTargetException e) {
            LOGGER.error("InvocationTargetException :: {}", e);
        } catch (Throwable throwable) {
            LOGGER.error("Throwable :: {}", throwable);
        }

        return resultObject;
    }

}
