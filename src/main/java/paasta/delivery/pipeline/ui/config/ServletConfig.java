package paasta.delivery.pipeline.ui.config;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Configuration;
import paasta.delivery.pipeline.ui.Application;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.config
 *
 * @author REX
 * @version 1.0
 * @since 5/10/2017
 */
@Configuration
public class ServletConfig extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

}
