package paasta.delivery.pipeline.ui.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.config
 *
 * @author REX
 * @version 1.0
 * @since 7 /4/2017
 */
public class WebSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/common/error/*", "/WEB-INF/jsp/sitemesh/errorDecorator.jsp")
                .addDecoratorPath("/dashboard/*", "/WEB-INF/jsp/sitemesh/defaultDecorator.jsp")
                .setIncludeErrorPages(true)
                .addExcludedPath("/admin/index");
    }

}
